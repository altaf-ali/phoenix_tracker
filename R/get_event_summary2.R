get_event_summary2 <- function(events, centroids, periodFROM = 7, periodTO = 0) {
  events <- events %>%
    filter(Date >= (max(Date) - days(periodFROM)) & Date <= (max(Date) - days(periodTO))) %>%
    filter(SourceActorRole == "GOV" & TargetActorRole == "GOV")
  
  nodes <- events %>%
    mutate(TargetActorEntity = ifelse(SourceActorEntity == TargetActorEntity, NA, TargetActorEntity)) %>%
    gather(ActorType, ActorEntity, SourceActorEntity, TargetActorEntity) %>%
    filter(!is.na(ActorEntity), !(ActorEntity == "")) %>%
    group_by(ActorEntity) %>%
    summarize(EventCount = n()) %>%
    mutate(CountryCode = countrycode(ActorEntity, "iso3c", "cown"), EventCount) %>%
    select(CountryCode, Country = ActorEntity, EventCount) %>%
    left_join(centroids, by = "Country") %>%
    arrange(desc(EventCount)) 
  
  edges <- events %>%
    filter(!is.na(SourceActorEntity), !(SourceActorEntity == ""),
           !is.na(TargetActorEntity), !(TargetActorEntity == ""),
           SourceActorEntity != TargetActorEntity) %>%
    rowwise() %>%
    mutate(Dyad = paste(sort(c(SourceActorEntity, TargetActorEntity)), collapse = "-")) %>%
    ungroup() %>%
    group_by(Dyad) %>%
    summarize(EventCount = n()) %>%
    ungroup() %>%
    separate(Dyad, c("SideA", "SideB"), "-", remove = FALSE) %>%
    mutate(CountryA = countrycode(SideA, "iso3c", "country.name"),
           CountryB = countrycode(SideB, "iso3c", "country.name")) %>%
    left_join(centroids, by = c("SideA" = "Country")) %>%
    select(Dyad, SideA, SideB, CountryA, CountryB, EventCount, SideA_Latitude = Latitude, SideA_Longitude = Longitude) %>%
    left_join(centroids, by = c("SideB" = "Country")) %>%
    select(Dyad, SideA, SideB, CountryA, CountryB, EventCount, SideA_Latitude, SideA_Longitude, SideB_Latitude = Latitude, SideB_Longitude = Longitude) %>%
    arrange(desc(EventCount))
  
  return(list(nodes = nodes, edges = edges))
}