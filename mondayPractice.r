
#load tidyverse 
library(tidyverse)
# download.file(
#   "https://raw.githubusercontent.com/datacarpentry/r-socialsci/main/episodes/data/SAFI_clean.csv",
#   "data-raw/SAFI_clean.csv", mode = "wb"
# )

#read data in
#na = null lets R know that when it sees null it means that 
#there is no data

interviews <- read_csv(
  "data-raw/SAFI_clean.csv", na = "NULL", 
)

# to create a section --------------------------------

# a section ---------------------------------------------------------------

  
class(interviews)
glimpse(interviews)
head(interviews)
tail(interviews)
summary(interviews)
str(interviews)
str(interviews$liv_count)

interviews[1,1]
interviews[1:3, 5]
interviews[ , 1:3]
interviews[ , -1]


#accessing variables by name

interviews$village
interviews["village"]

area_hectares <- 1.0
area_acres <- area_hectares*2.47
area_hectares <- 2.5

round(3.14159)
args(round)
?round #to get more explanations
round(3.14159, digits = 2) #this rounds to 2 decimal places

hh_members <- c(3,7,10,6)

hh_members[2:length(hh_members)]

hh_members <- c(hh_members, NULL) #to add null to our list

hh_members <- c(3,7,10,6)
logi_vec <- c(TRUE, FALSE, TRUE)
c(1, logi_vec)
c("word", logi_vec)
hh_members <- c(hh_members, NA) #to add NA as an option in the household members

mean(hh_members, na.rm = TRUE) #to calculate the mean for only actual value and not include NAs

max(hh_members, na.rm=TRUE)
hh_members[!is.na(hh_members)]

na.omit(hh.members) #removes NA and tells us the index where it was at

#now we are working with factors

respondent_floor_type <- factor(c("earth", "cement", "cement", "earth"))
levels(respondent_floor_type)
respondent_floor_type

days_of_week <- factor

dates <- interviews$interview_date 
str(dates)

interviews$day <- day(dates)
interviews$month <- month(dates)
interviews$year <-  year(dates)

dates[1] + days(30) #adding 30 days 

dates[1] + months(30)

#select 
select(interviews, village, no_membrs, months_lack_food, memb_assoc)

select(interviews, village:years_liv)


#filter 
#first argument is always the source data

filter(interviews, 
       village =="Chirodzo",
       rooms > 1,
       no_meals > 2)

interviews |> 
  select(-key_ID) |>
  filter(village=="Chirodzo",
          rooms > 1,
          no_meals > 2)

interviews |> 
  select(-key_ID) |>
  filter(village=="Chirodzo" | village =="Ruaca")

#mutate (new columned created based on existing columns)

interviews |> 
  
  mutate(people_per_room = no_membrs / rooms) |>
  glimpse()

#create people per room by only for cases where family is member of an irrigation association 
interviews |> 
  mutate(people_per_room = no_membrs / rooms) |>
  filter(memb_assoc == "yes")

interviews |>
  group_by(village) |>
  summarize(mean_no_membrs = mean(no_membrs),
            .groups = "drop")

write_csv(x= means_no_memb,
          file = "data/means_no_memb.csv")

