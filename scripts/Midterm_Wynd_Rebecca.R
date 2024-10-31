#Read in the file tyler_activity_laps_10-24.csv from the class github page. This file is at url https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.
library(tidyverse)
url <- "https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv" # Read in the CSV file 
tyler_activity_laps <- read_csv(url)

#Filter out any non-running activities.
unique(tyler_activity_laps$sport)
tyler_running <- tyler_activity_laps %>% 
  filter(sport %in% "running")

#Next, Tyler often has to take walk breaks between laps right now because trying to change how you’ve run for 25 years is hard. You can assume that any lap with a pace above 10 minute-per-mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute-per-mile pace) and abnormally short records where the total elapsed time is one minute or less.
#remove: pace above 10 minute-per-mile, < 5 minute-per-mile pace, abnormally short records where the total elapsed time is one minute or less
tyler_running_filter_pace <- tyler_running %>% 
  filter(minutes_per_mile <=10 & minutes_per_mile>=5 & total_elapsed_time_s>1)

#Create a new categorical variable, pace, that categorizes laps by pace: “fast” (< 6 minutes-per-mile), “medium” (6:00 to 8:00), and “slow” ( > 8:00). Create a second categorical variable, form that distinguishes between laps run in the year 2024 (“new”, as Tyler started his rehab in January 2024) and all prior years (“old”).
tyler_running_new_category <- tyler_running_filter_pace %>% 
  mutate(pace = case_when(
    minutes_per_mile <6 ~ "fast",
    minutes_per_mile >=6 & minutes_per_mile <=8 ~ "medium",
    minutes_per_mile >8 ~ "slow",
    is.na(minutes_per_mile) ~ NA_character_,
    TRUE ~ "other"
  )) %>% 
  mutate(form = case_when(
    year %in% 2024 ~ "new",
    year <= 2023 ~ "old",
    is.na(year) ~ NA_character_,
    TRUE ~ "old"
  ))

#Identify the average steps per minute for laps by form and pace, and generate a table showing these values with old and new as separate rows and pace categories as columns. Make sure that slow speed is the second column, medium speed is the third column, and fast speed is the fourth column (hint: think about what the select() function does).

tyler_running_new_table <- tyler_running_new_category %>% 
  group_by(form,pace) %>% 
  summarize(mean_steps = mean(steps_per_minute)) %>%
  pivot_wider(names_from = pace, values_from = mean_steps) %>% 
  select(form, slow, medium, fast) #reorders column 

#Finally, Tyler thinks he’s been doing better since July after the doctors filmed him running again and provided new advice. Summarize the minimum, mean, median, and maximum steps per minute results for all laps (regardless of pace category) run between January - June 2024 and July - October 2024 for comparison.

tyler_2024_1 <- tyler_running_new_category %>% 
  filter(year == 2024 & month >=1 & month <=6) %>% # ran out of time at this point! 
  summarise(steps_per_minute_min = min(steps_per_minute))

#midterm answer for last part:
tyler_running_new_category %>% filter(form == 'new') %>%
  mutate(months = ifelse(month %in% 1:6,'early 2024','late 2024')) %>%
  group_by(months) %>% 
  summarize(
    min_spm = min(steps_per_minute), # I got a different number than the answer page here
    median_spm = median(steps_per_minute),
    mean_spm = mean(steps_per_minute),
    max_spm = max(steps_per_minute))

