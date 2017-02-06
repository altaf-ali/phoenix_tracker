# load the dataset
phoenix_load <- function(config, start_date = NULL) {
  phoxy::update_phoenix(config$phoenix$path, start_date = start_date)
  return(phoxy::ingest_phoenix(config$phoenix$path))
}
