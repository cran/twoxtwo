## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#",
  warning = FALSE,
  message = FALSE
)

## -----------------------------------------------------------------------------
library(twoxtwo)

titanic %>%
  chisq(., Crew, Survived)

## -----------------------------------------------------------------------------
library(dplyr)
library(tidyr)

tea <-
  tribble(
    ~poured, ~guessed, ~ n,
    "Milk", "Milk", 3,
    "Milk", "Tea", 1,
    "Tea", "Milk", 1,
    "Tea", "Tea", 3
    ) %>%
  uncount(n)

tea %>%
  twoxtwo(., poured, guessed, 
          levels = list(exposure = c("Milk","Tea"), outcome = c("Milk","Tea")))

## -----------------------------------------------------------------------------
tea %>%
  fisher(., poured, guessed, 
         levels = list(exposure = c("Milk","Tea"), outcome = c("Milk","Tea")))

## -----------------------------------------------------------------------------
titanic %>% 
  fisher(., exposure = Crew, outcome = Survived, alternative = "greater")

## -----------------------------------------------------------------------------
titanic %>% 
  fisher(., exposure = Crew, outcome = Survived, alternative = "less")

## -----------------------------------------------------------------------------
titanic %>% 
  fisher(., exposure = Crew, outcome = Survived, alternative = "two.sided")

## -----------------------------------------------------------------------------
titanic %>% 
  fisher(., exposure = Crew, outcome = Survived, or = 2)

