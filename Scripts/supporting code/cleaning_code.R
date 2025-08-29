##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##--------------------------- DATA CLEANING SCRIPT------------------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Loading in libraries
library(dplyr)
library(tidyverse)
library(here)

# Reading in CSVs
Q1 <-read_csv(here::here("data", "raw_data", "QuebradaCuenca1-Bisley.csv"))
Q2 <- read_csv(here::here("data", "raw_data", "QuebradaCuenca2-Bisley.csv"))
Q3 <- read_csv(here::here("data", "raw_data", "QuebradaCuenca3-Bisley.csv"))
PRM <- read_csv(here::here("data", "raw_data", "RioMameyesPuenteRoto.csv"))

# Making all variables lower case in all data frames
Q1janitor <- Q1 |>
  janitor::clean_names()
Q2janitor <- Q2 |>
  janitor::clean_names()
Q3janitor <- Q3 |>
  janitor::clean_names()
PRMjanitor <- PRM |>
  janitor::clean_names()

#filtering out unnecessary columns in all data frames. We only need sample_id, sample_date, nh4_n, ca, mg, no3_n, and k to calculate our rolling averages
clean_q1 <- Q1janitor |>
  select(sample_id, sample_date, nh4_n, ca, mg, no3_n, k) |>
  mutate(year = lubridate::year(sample_date)) |> # Making a column for year
  filter(year <= 1995, year >= 1988) |> # only keeping years from 1988-1995
  arrange(sample_date)

clean_q2 <- Q2janitor |>
  select(sample_id, sample_date, nh4_n, ca, mg, no3_n, k) |>
  mutate(year = lubridate::year(sample_date)) |>
  filter(year <= 1995, year >= 1988) |>
  arrange(sample_date)

clean_q3 <- Q3janitor |>
  select(sample_id, sample_date, nh4_n, ca, mg, no3_n, k) |>
  mutate(year = lubridate::year(sample_date)) |>
  filter(year <= 1995, year >= 1988) |>
  arrange(sample_date)

clean_prm <- PRMjanitor |>
  select(sample_id, sample_date, nh4_n, ca, mg, no3_n, k) |>
  mutate(year = lubridate::year(sample_date)) |>
  filter(year <= 1995, year >= 1988) |>
  arrange(sample_date)


# Taking the duplicate dates out of each data set and randomly selecting 1 to keep
q1_unique <- clean_q1 |>
  group_by(sample_date) |>
  slice_sample(n = 1) |>
  ungroup()

q2_unique <- clean_q2 |>
  group_by(sample_date) |>
  slice_sample(n = 1) |>
  ungroup()

q3_unique <- clean_q3 |>
  group_by(sample_date) |>
  slice_sample(n = 1) |>
  ungroup()

prm_unique <- clean_prm |>
  group_by(sample_date) |>
  slice_sample(n = 1) |>
  ungroup()


# Saving cleaned data frames to new CSVs 
write.csv(q1_unique, file = here("outputs", "cleaned_data", "q1_unique.csv"), row.names = FALSE)
write.csv(q2_unique, file = here("outputs", "cleaned_data", "q2_unique.csv"), row.names = FALSE)
write.csv(q3_unique, file = here("outputs", "cleaned_data", "q3_unique.csv"), row.names = FALSE)
write.csv(prm_unique, file = here("outputs", "cleaned_data", "prm_unique.csv"), row.names = FALSE)

