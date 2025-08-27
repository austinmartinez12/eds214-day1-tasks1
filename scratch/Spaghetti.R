##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##--------------------------------- # CONTENT-----------------------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(dplyr)
library(tidyverse)
library(zoo)

Q1 <-read_csv(here::here("Data", "QuebradaCuenca1-Bisley.csv"))
Q2 <- read_csv(here::here("Data", "QuebradaCuenca2-Bisley.csv"))
Q3 <- read_csv(here::here("Data", "QuebradaCuenca3-Bisley.csv"))
PRM <- read_csv(here::here("Data", "RioMameyesPuenteRoto.csv"))

bruh <- Q1 |>
  janitor::clean_names()
  
clean_Q1 <- bruh |>
  select(sample_date, nh4_n, ca, mg, no3_n, k) |>
  mutate(year = lubridate::year(sample_date)) |>
  filter(year <= 1995, year >= 1988) |>
  arrange(sample_date)

clean_Q1_unique <- clean_Q1 |>
  group_by(sample_date) |>
  slice_sample(n = 1) |>
  ungroup()

 Q1_rollmean <- clean_Q1_unique |>
  mutate( nh4_n_rolling_mean = rollmean(nh4_n, k = 9, fill = NA, align = "center")) |>
  mutate( ca_rolling_mean = rollmean(ca, k = 9, fill = NA, align = "center")) |>
  mutate( mg_rolling_mean = rollmean(mg, k = 9, fill = NA, align = "center")) |>
  mutate( no3_n_rolling_mean = rollmean(no3_n, k = 9, fill = NA, align = "center")) |>
  mutate( k_n_rolling_mean = rollmean(k, k = 9, fill = NA, align = "center"))

ggplot(data = Q1_rollmean, aes(x = sample_date, y = ca_rolling_mean)) +
  geom_line() +
  theme_minimal() +
  labs(
  



