library(yaml)

# install phoxy if not already installed
if (!require(phoxy))
  devtools::install_github("altaf-ali/phoxy")

# update the dataset
phoenix_load <- function(config, start_date = NULL) {
  update_phoenix(config$phoenix$path, start_date = start_date)
  return(ingest_phoenix(config$phoenix$path))
}
