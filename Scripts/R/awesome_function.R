
# making a function for all the themes of my ggplot

awesome_theme <- function(lazy) {
  list(  
    facet_wrap(~contaminant, scales = "free_y", ncol = 1, strip.position = "left", 
               # as_labeller is changing the names on the y axes of the plots 
               labeller = as_labeller(c(
                 nh4_n_rolling_avg = "NH4-N ug L-¹",
                 ca_rolling_avg    = "Ca mg L-¹",
                 mg_rolling_avg    = "Mg mg L-¹",
                 no3_n_rolling_avg = "NO3-N ug L-¹",
                 k_rolling_avg     = "K mg L-¹" ))) ,
    theme_linedraw() , 
    # The code below changes the names of all the elements
    labs(x = "Year", y = "Rolling Averages", color = "Streams", title = "Hurricane Effects on Stream Chemistry") , 
    geom_vline(xintercept = hurricane_date, linetype = "dashed") , # This adds a line showing the hurricane occurance date
    scale_color_manual( # This changes the color of each line
      values = c("Q1" = "red",
                 "Q2" = "dodgerblue",
                 "Q3" = "green",
                 "MPR" = "purple")) , 
    theme(strip.placement = "outside", # The y axis labels had by default white letters and black boxes, so I changes it to white text and no black box behind the text.
          strip.background = element_blank(),
          strip.text = element_text(color = "black"))
  )
  
}