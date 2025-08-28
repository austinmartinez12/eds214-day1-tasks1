library(dplyr)
library(tidyverse)
library(zoo)
library(slider)

# Reading in CSVs
Q1 <-read_csv(here::here("Data", "QuebradaCuenca1-Bisley.csv"))
Q2 <- read_csv(here::here("Data", "QuebradaCuenca2-Bisley.csv"))
Q3 <- read_csv(here::here("Data", "QuebradaCuenca3-Bisley.csv"))
PRM <- read_csv(here::here("Data", "RioMameyesPuenteRoto.csv"))

# Making all variables lower case in all data frames
Q1janitor <- Q1 |>
  janitor::clean_names()
Q2janitor <- Q2 |>
  janitor::clean_names()
Q3janitor <- Q3 |>
  janitor::clean_names()
PRMjanitor <- PRM |>
  janitor::clean_names()

#filtering out unnecessary columns in all data frames. # We only need sample_id, sample_date, nh4_n, ca, mg, no3_n, and k to calculate our rolling averages
clean_q1 <- Q1janitor |>
  select(sample_id, sample_date, nh4_n, ca, mg, no3_n, k) |>
  mutate(year = lubridate::year(sample_date)) |>
  filter(year <= 1995, year >= 1988) |>
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


# Taking out duplicate dates out of each data set and randomly selecting 1 to keep
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

# Calculation centered moving average for NH4_N, Ca, Mg, NO3_N, and K for each data with a 9 week sliding window.
# Calculation moving average for Q1
q1collumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in q1collumns) {
  q1_unique <- q1_unique %>% # Won't work with |> pipes. 
    mutate(
      !!paste0(col, "_rolling_avg") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = ~mean(.x, na.rm = TRUE),
        .before = (7*9)/2,   
        .after  = (7*9)/2,
        .complete = FALSE
      )
    )
}

# Calculation moving average for Q2
q2collumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in q2collumns) {
  q2_unique <- q2_unique %>%
    mutate(
      !!paste0(col, "_rolling_avg") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = ~mean(.x, na.rm = TRUE),  
        .before = (7*9)/2,
        .after  = (7*9)/2,
        .complete = FALSE
      )
    )
}

# Calculation moving average for Q3
q3collumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in q3collumns) {
  q3_unique <- q3_unique %>%
    mutate(
      !!paste0(col, "_rolling_avg") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = ~mean(.x, na.rm = TRUE),  
        .before = (7*9)/2, 
        .after  = (7*9)/2,
        .complete = FALSE
      )
    )
}

# Calculation moving average for Q3
prmcollumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in prmcollumns) {
  prm_unique <- prm_unique %>%
    mutate(
      !!paste0(col, "_rolling_avg") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = ~mean(.x, na.rm = TRUE),
        .before = (7*9)/2,
        .after  = (7*9)/2,
        .complete = FALSE
      )
    )
}

# Combing all data sets(q1_unique, q2_unique, q3_unique, prm_unique) into one.
river_df <- bind_rows(q1_unique, q2_unique, q3_unique, prm_unique)

# Pivoting longer so I can facet wrap my ggplot for contaminants
river_long <- pivot_longer(data = river_df, 
                           cols =  c("nh4_n_rolling_avg", "ca_rolling_avg", 
                                     "mg_rolling_avg", "no3_n_rolling_avg", "k_rolling_avg"), 
                           names_to = "contaminant",
                           values_to = "rolling_avgs")


# Generates ggplot 
# I'm still unsure if I use the bottom or top one.
# I still need to add that line that shows when the hurricane is at.

# Keeps the NAs in rolling_avgs
ggplot(data = river_long, aes(x = sample_date, y = rolling_avgs, color = sample_id)) +
  geom_line() + facet_wrap(~contaminant, scales = "free_y", ncol = 1) +
  theme_linedraw()+ labs(x = "Year", y = "Rolling Means")

# Removes the NAs in rolling_avgs
ggplot(data = river_long %>% 
         filter(!is.na(rolling_avgs)),
  aes(x = sample_date, y = rolling_avgs, color = sample_id)) +
  geom_line() + facet_wrap(~contaminant, scales = "free_y", ncol = 1) +
  theme_linedraw()+ labs(x = "Year", y = "Rolling Means")


















# This is just code I been playing with NOT IMPORTANT

moving_average <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc, na.rm = TRUE)
  
  return(result)
}

# Class activity stuff. shows function works
tiny_problem <- data.table::data.table(
  sample_date = c("2001-07-29","2001-12-04","2002-03-11",
                  "2002-06-07","2002-07-03","2002-07-12","2002-08-04",
                  "2002-08-05","2002-08-06","2002-08-07"),
  sample_id = c("Q1", "Q1", "Q1", "Q1", "Q1", "Q1", "Q1", "Q1", "Q1", "Q1"),
  ca = c(0.456,0.278,0.892,0.498,0.273,0.3757,
         0.3828,0.583,0.2543,0.324),
  rolling_avg = c(0.456,0.278,0.892,0.3855,0.382375,
                  0.3844,0.38396,0.38396,0.38396,0.38396)
)

ca_ma_once <- moving_average(focal_date = as.Date("2001-12-04"),
                             dates = tiny_problem$sample_date,
                             conc = tiny_problem$ca,
                             win_size_wks = 9)

tiny_problem$sample_date <- as.Date(tiny_problem$sample_date)
tiny_problem$calc_rolling <- sapply(
  tiny_problem$sample_date,
  moving_average,
  dates = tiny_problem$sample_date,
  conc = tiny_problem$ca,
  win_size_wks = 9
)



# make dates = Date objects
# This code is to show professor that class code gets same values as my function
q1_unique$sample_date <- as.Date(q1_unique$sample_date)

q1_unique <- q1_unique %>%
  mutate(
    ca_class = sapply(
      sample_date,
      moving_average,
      dates = sample_date,
      conc = ca,
      win_size_wks = 9
    ),
    nh4_class = sapply(
      sample_date,
      moving_average,
      dates = sample_date,
      conc = nh4_n,
      win_size_wks = 9
    ),
    mg_class = sapply(
      sample_date,
      moving_average,
      dates = sample_date,
      conc = mg,
      win_size_wks = 9
    ),
    no3_class = sapply(
      sample_date,
      moving_average,
      dates = sample_date,
      conc = no3_n,
      win_size_wks = 9
    ),
    k_class = sapply(
      sample_date,
      moving_average,
      dates = sample_date,
      conc = k,
      win_size_wks = 9
    )
  )





