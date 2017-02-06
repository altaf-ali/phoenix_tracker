# Phoenix Tracker

[![Build Status](https://travis-ci.org/altaf-ali/phoenix_tracker.svg?branch=master)](https://travis-ci.org/altaf-ali/phoenix_tracker)

## Getting Started

- Run `R/setup.R` to ensure that you have the necessary packages installed.
- Use `Build All` command in RStudio to build the project.

## Adding Content

If you're adding new content to this repository, simply follow these steps:

- Create a new markdown file and add it to the `rmd_files` section of `_bookdown.yml`
- Update the `Imports` section of `DESCRIPTION` file if your code depends on packages not already included
- Commit and push your changes to GitHub.

## Automatic Builds

The project is setup to build  whenever new changes are pushed to the repository. The project also builds automatically on a daily basis on [Travis/CI](https://travis-ci.org/altaf-ali/phoenix_tracker) and fetches the latest datasets from the Phoenix Dataset site. 
