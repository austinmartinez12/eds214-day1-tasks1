library(dplyr)
library(tidyverse)
library(zoo)
library(slider)

Q1 <-read_csv(here::here("Data", "QuebradaCuenca1-Bisley.csv"))
Q2 <- read_csv(here::here("Data", "QuebradaCuenca2-Bisley.csv"))
Q3 <- read_csv(here::here("Data", "QuebradaCuenca3-Bisley.csv"))
PRM <- read_csv(here::here("Data", "RioMameyesPuenteRoto.csv"))

#making all variables lower case in all data drames
Q1janitor <- Q1 |>
  janitor::clean_names()
Q2janitor <- Q2 |>
  janitor::clean_names()
Q3janitor <- Q3 |>
  janitor::clean_names()
PRMjanitor <- PRM |>
  janitor::clean_names()

# Variable and function names should use only lowercase letters, numbers, and _. Use underscores (_) (so called snake case) to separate words within a name.
# Variable and function names should use only lowercase letters, numbers, and _. Use underscores (_) (so called snake case) to separate words within a name.

#filtering out unessesary collumns in all data frames
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


# Taking out duplicate dates out of each data set
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

# Calculation moving average for NH4_N, Ca, Mg, NO3_N, and K for each data set
#Q1
q1collumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in q1collumns) {
  q1_unique <- q1_unique %>%
    mutate(
      !!paste0(col, "_rolling_mean") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = mean,
        .before = 7*9,
        .after = 0,
        .complete = FALSE,
        na.rm = TRUE
      )
    )
}

q2collumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in q2collumns) {
  q2_unique <- q2_unique %>%
    mutate(
      !!paste0(col, "_rolling_mean") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = mean,
        .before = 7*9,
        .after = 0,
        .complete = FALSE,
        na.rm = TRUE
      )
    )
}

q3collumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in q3collumns) {
  q3_unique <- q3_unique %>%
    mutate(
      !!paste0(col, "_rolling_mean") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = mean,
        .before = 7*9,
        .after = 0,
        .complete = FALSE,
        na.rm = TRUE
      )
    )
}

prmcollumns <- c("nh4_n", "ca", "mg", "no3_n", "k")
for (col in prmcollumns) {
  prm_unique <- prm_unique %>%
    mutate(
      !!paste0(col, "_rolling_mean") := slide_index_dbl(
        .x = .[[col]],
        .i = sample_date,
        .f = mean,
        .before = 7*9,
        .after = 0,
        .complete = FALSE,
        na.rm = TRUE
      )
    )
}


river_df <- bind_rows(q1_unique, q2_unique, q3_unique, prm_unique)
river_long <- pivot_longer(data = river_df, 
             cols =  c("nh4_n_rolling_mean", "ca_rolling_mean", 
                 "mg_rolling_mean", "no3_n_rolling_mean", "k_rolling_mean"), 
             names_to = "contaminant",
             values_to = "rolling_means")

river_df2 <- river_df(!is.nan(river_df)
river_df2 <- na.omit(river_df)
                                            

#If the arguments to a ggplot2 layer don’t all fit on one line, put each argument on its own line and indent:
#If you are creating a ggplot off of a dplyr pipeline, there should only be one level of indentation.

ggplot(data = river_long, aes(x = sample_date, y = rolling_means, color = sample_id)) +
  geom_line() +
  facet_wrap(~contaminant, scales = "free_y")
  theme_minimal() +
  labs(x = "Year", y = "Calcium Rolling Mean")


















df<- q1_unique|>
  mutate(
    roll_mean = slide_index_dbl(
      .x = ca, 
      .i = sample_date, 
      .f = mean, 
      .before = 7*9,   # 9 weeks (days before)
      .after = 0, 
      .complete = FALSE,
      na.rm = TRUE
    )
  )



#class function
moving_average <- function(focal_date, dates, conc, win_size_wks) {
  #subset the dates in the window
  is_in_window <- (dates > focal_date - (win_size_wks / 2) *7) &
    (dates < focal_date + (win_size_wks / 2) * 7) 
  #find th assosiated concs
  window_conc <- conc[is_in_window]
  #calculate the mean
  result <- mean(window_conc)
  
  return(result)
}

ca_ma_1990_04_05 <- moving_average(focal_date = as.Date("1990-04-05"),
                                   dates = tiny_problem$sample_date,
                                   conc = tiny_problem$ca, 
                                   win_size_wks = 9)
ca_ma_once <- moving_average(focal_date = as.Date("2001-12-04"),
                                   dates = tiny_problem$sample_date,
                                   conc = tiny_problem$ca, 
                                   win_size_wks = 9)

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

tiny_problem$calc_rolling <- sapply(
  tiny_problem$sample_date,
  moving_average,
  dates = tiny_problem$sample_date,
  conc = tiny_problems$ca,
  win_size_wks = 9
  )



