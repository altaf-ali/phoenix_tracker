library(tidyverse)
library(ggmap)
library(countrycode)
library(yaml)

rm(list = ls())

config <- yaml.load_file("config.yml")

countrycodes <- bind_rows(lapply(0:(nrow(countrycode_data)/config$google$max_requests), function(i) {
  start <- i*config$google$max_requests +1
  end <- min(start + config$google$max_requests -1, nrow(countrycode_data))
  print(sprintf("Processing rows %3d to %3d", start, end))

  countries <- countrycode_data %>%
    filter(!is.na(iso3c)) %>%
    select(country.name, iso3c) %>%
    filter(row_number() %in% start:end)

  geocodes <- bind_cols(countries, geocode(countries$country.name))

  print(sprintf("Sleeping for %d seconds", config$google$timeout))
  Sys.sleep(config$google$timeout)

  left_join(countries, geocodes, by = c("country.name", "iso3c"))
}))

countrycodes <- countrycodes %>%
  select(Country = iso3c, CountryName = country.name, Longitude = lon, Latitude = lat)

dir.create(dirname(config$google$centroids), recursive = TRUE)
write_csv(countrycodes, config$google$centroids)
