library(dplyr)
library(tidyverse)

Q1 <-read_csv(here::here("Data", "QuebradaCuenca1-Bisley.csv"))
Q2 <- read_csv(here::here("Data", "QuebradaCuenca2-Bisley.csv"))
Q3 <- read_csv(here::here("Data", "QuebradaCuenca3-Bisley.csv"))
PRM <- read_csv(here::here("Data", "RioMameyesPuenteRoto.csv"))

# Based on the caption of figure 3, write down the steps you think will be necessary to reproduce figure 3.
#1. merge the data for PRM, BQ1, BQ2, BQ3
#2. lubridate the years
#3 subset the data so it only has data for (a) potassium, (b) nitrate-N, (c) magnesium, (d) calcium and (e) ammonium-N. and 1988 - 1989

