##visualization with ggplot2 

#set up script -------------------------------------------------------------------

library(tidyverse)

interviews_plotting <-read_csv("data/interviews-plotting.csv")

interviews_plotting |>
  ggplot(mapping = aes(x = no_membrs, y = number_items)) + geom_point(alpha = 0.5)

#mapping vs seeting 

interviews_plotting|>
  filter_out(is.na(memb_assoc)) |>
  ggplot(mapping = aes(x = no_membrs, y = number_items,
                       color = village,
                       shape = memb_assoc)) + 
  geom_jitter(alpha = 0.7,
              width = 0.2,
              height = 0.2
              )

#there are options for color blindness on his website 

interviews_plotting |> 
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot()


#investigate the plot

interviews_plotting |> 
  count(respondent_wall_type)

interviews_plotting |> 
  filter(respondent_wall_type != "cement") |> 
  ggplot(aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot(outliers = FALSE) +
  geom_jitter(aes(color = village),
              width = 0.3,
              height = 0.1)

#fct_infreq is to order the bars
#village can be counties ?
interviews_plotting |> 
  ggplot(aes(y = fct_infreq(respondent_wall_type))) +
  geom_bar(aes(fill = village)) + 
  labs(y = "Wall type",
       x = NULL,
       fill = "Village") +
  theme_classic()

ggsave("fig/wall_type.png", height = 15, width =10) #to save the image generated 
