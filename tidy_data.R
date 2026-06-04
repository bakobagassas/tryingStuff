## Tidying Data

library(tidyverse)

interviews <- read_csv(file = "data-raw/SAFI_clean.csv", na = "NULL")

# Mean number of members 
# and the minimum number of members 
# per village and member association without 
# NAs in the member association

interviews |> 
  filter(!is.na(memb_assoc)) |> 
  group_by(village, memb_assoc) |> 
  summarize(mean_no_members = mean(no_membrs), 
            min_no_members = min(no_membrs)) |> 
  ungroup()

# OR

interviews |> 
  filter(!is.na(memb_assoc)) |> 
  group_by(village, memb_assoc) |> 
  summarize(mean_no_members = mean(no_membrs), 
            min_no_members = min(no_membrs), 
            .groups = "drop") # Un-grouping in summarize

# OR

interviews |> 
  filter(!is.na(memb_assoc)) |> 
  summarize(mean_no_members = mean(no_membrs), 
            min_no_members = min(no_membrs), 
            no_households = n(),
            .by = c(village, memb_assoc)) # grouping within summarize

# Count function
interviews |> 
  count(village, memb_assoc, sort = TRUE) # the sort argument arranges the counts in descending order

interviews |> 
  filter(!is.na(memb_assoc)) |> 
  summarize(mean_no_members = mean(no_membrs), 
            min_no_members = min(no_membrs), 
            no_households = n(),
            .by = c(village, memb_assoc)) |> 
  arrange(no_households, mean_no_members) # changes just the display of the data

# filtering using filter_out
interviews |> 
  filter_out(is.na(memb_assoc)) |> 
  mutate(per_room = no_membrs/rooms) |> 
  summarise(mean_per_room = mean(per_room),
            min_room = min(rooms), 
            households = n(),
            .by = c(village, memb_assoc)) |> 
  arrange(desc(households))


# Tidy data ---------------------------------------------------------------

interviews_items_owned <- interviews |> 
  separate_longer_delim(items_owned, delim = ";") |> 
  replace_na(list(items_owned = "no listed items")) |>  # takes a list of columns that contains NAs and replace with something else
  mutate(items_logical = TRUE) |> 
  group_by(key_ID) |> 
  mutate(number_items = if_else(
    condition = items_owned == "no_listed_items", true = 0, false = n()
  )) |> 
  pivot_wider(names_from = items_owned, 
              values_from = items_logical,
              values_fill = list(items_logical = FALSE)) 

interviews_plotting <- interviews_items_owned |> 
  separate_longer_delim(months_lack_food, delim = ";") |>
  group_by(key_ID) |> # making sure it is still grouped by key_ID
  mutate(months_logical = TRUE,
         no_months_lack_food = if_else(
           condition = months_lack_food == "none", true = 0, false = n()
         )) |> 
  pivot_wider(names_from = months_lack_food, 
              values_from = months_logical, 
              values_fill = list(months_logical = FALSE))
write_csv(interviews_plotting, "data/interviews-plotting.csv")
