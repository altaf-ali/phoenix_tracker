if (!file.exists("DESCRIPTION")) {
  stop("DESCRIPTION file does not exist in the current directory. Make sure you're in the project directory before running this script.")
}

installed_packages <- installed.packages()

if (!("phoxy" %in% installed_packages) || packageVersion("phoxy") != '0.2')
  devtools::install_github("altaf-ali/phoxy")

if (!("yaml" %in% installed_packages))
  install.packages("yaml")

desc <- yaml::yaml.load_file("DESCRIPTION")

for (package_name in strsplit(desc$Imports, ",")[[1]]) {
  package_name <- trimws(package_name)
  if (package_name %in% installed_packages)
    print(paste(package_name, "already installed"))
  else
    install.packages(package_name)
}

