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
  odds_ratio(.data = ., exposure = Crew, outcome = Survived)

## -----------------------------------------------------------------------------
titanic %>%
  risk_ratio(.data = ., exposure = Crew, outcome = Survived)

## -----------------------------------------------------------------------------
titanic %>%
  risk_diff(.data = ., exposure = Crew, outcome = Survived)

## -----------------------------------------------------------------------------
library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)

## write a helper function to compute odds ratio and risk ratio
## this function will stack the two outputs on top of one another as a tibble
or_rr <- function(incidence = 0.8) {
  
  ## define counts in two-by-two cells based on the incidence proportion
  A <- round(100*incidence)
  B <- 100 - A
  C <- 10
  D <- 90
  
  ## create a tibble with observation level data from the counts above
  dat <-
    tribble(~x, ~y, ~n,
            TRUE, TRUE, A,
            TRUE, FALSE, B,
            FALSE,TRUE, C,
            FALSE, FALSE, D) %>%
    uncount(n)
  
  ## calculate odds ratio and risk ratio
  or <- odds_ratio(dat, exposure = x, outcome = y)
  rr <- risk_ratio(dat, exposure = x , outcome = y)
  
  ## stack the two on top of one another
  ## add a column with incidence
  bind_rows(or,rr) %>%
    mutate(Incidence = incidence)
}

## iterate over all incidence values from 0.025 to 0.5 (in 0.025 increments)
## combine results as a tibble
res <-
  seq(0.025, 0.5, by = 0.025) %>%
  map_df(., or_rr)

## ---- echo=FALSE--------------------------------------------------------------
res %>%
  select(Measure = measure, Estimate = estimate, Incidence) %>%
  mutate(Estimate = round(Estimate, 3)) %>%
  spread(Measure, Estimate) %>%
  knitr::kable(.)

## ---- fig.width=7, fig.height=5, fig.align="center", echo = FALSE-------------
res %>%
  ggplot(aes(Incidence, estimate)) +
  geom_line(aes(group = measure, col = measure), lwd = 0.75) +
  scale_y_log10() +
  theme_minimal() +
  labs(x = "Incidence", y = "Estimate") +
  theme(legend.position = "bottom", legend.title = element_blank())

