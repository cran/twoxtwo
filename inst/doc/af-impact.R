## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#",
  warning = FALSE,
  message = FALSE
)

## -----------------------------------------------------------------------------
library(dplyr)
library(tidyr)

chd_smoke <-
  tribble(~smoke, ~chd_died,~n,
          TRUE, TRUE,69,
          TRUE, FALSE, 10263,
          FALSE, TRUE, 100,
          FALSE, FALSE, 24008) %>%
  uncount(n)

## -----------------------------------------------------------------------------
library(twoxtwo)

chd_smoke %>%
  twoxtwo(., exposure = smoke, outcome = chd_died)

## -----------------------------------------------------------------------------
chd_smoke %>%
  arp(exposure =  smoke, outcome = chd_died)

## -----------------------------------------------------------------------------
chd_smoke %>%
  arp(exposure =  smoke, outcome = chd_died, percent = TRUE)

## -----------------------------------------------------------------------------
chd_smoke %>%
  parp(exposure =  smoke, outcome = chd_died)

## -----------------------------------------------------------------------------
chd_smoke %>%
  parp(exposure =  smoke, outcome = chd_died, percent = TRUE)

## -----------------------------------------------------------------------------
chd_smoke %>%
  parp(exposure =  smoke, outcome = chd_died, percent = TRUE, prevalence = 0.2)

## -----------------------------------------------------------------------------
chd_smoke %>%
  ein(exposure = smoke, outcome = chd_died)

## -----------------------------------------------------------------------------
chd_smoke %>%
  cin(exposure = smoke, outcome = chd_died)

## -----------------------------------------------------------------------------
chd_smoke %>%
  ecin(exposure = smoke, outcome = chd_died)

