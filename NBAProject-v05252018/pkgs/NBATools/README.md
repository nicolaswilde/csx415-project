## Package

Package "devtools" is used to build my own package "NBATools", which located in /pkgs/NBATools.

## Demo

Try /pkgs/NBATools/demo.Rmd

## Install

How to install "NBATools"?

- Use RStudio

    - setwd("yourpath/csx415-project\NBAProject-v05062018\pkgs\NBATools")

    - library(devtools)

    - install(".")

- Use Rscript

    - cd yourpath/csx415-project\NBAProject-v05062018\pkgs\NBATools

    - Rscript setup.R

## Test

Simple test has been designed to test package "NBATools", you can test

- Use Rstudio

    - setwd("yourpath/csx415-project\NBAProject-v05062018\pkgs\NBATools")

    - library(devtools)

    - test()
