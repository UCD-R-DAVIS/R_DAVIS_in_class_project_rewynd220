#For the midterm, you compared Tyler’s old running data with recent data to analyze to see if there was any difference in strides-per-minute (SPM). On July 1, 2024, Tyler went to a follow-up appointment with the UCD Sports Medicine clinic, and they told him that has cadence was still too low, and that his form was perhaps more damaging than it had been. The technician gave Tyler some training cues, as well as the advice that “elite professional runners are at least 180 strides-per-minute, so aim for that”.

#Tyler looked into it, and found out that:
  
  #He is not an elite professional runner

#That 180 number was based on strides counted in the 1984 MEN’S OLYMPIC 10K FINAL (seriously, this is true)

#Given these two facts, the conclusion (since confirmed with technician) is that what really matters is not just high cadence but a positive relationship between cadence and speed. Perform the tasks below to analyze whether Tyler’s SPM appears responsive to changes in pace, and more importantly whether things have improved since the July 1 check-up.

#TASK DESCRIPTION

#Read in the file tyler_activity_laps_12-6.csv from the class github page. This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.

library(tidyverse)
library(ggplot2)

url <- "https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv" # Read in the CSV file 
tyler_activity_laps <- read_csv(url)


#Filter out any non-running activities.
unique(tyler_activity_laps$sport)

tyler_running <- tyler_activity_laps %>% 
  filter(sport %in% "running")

#We are interested in normal running. You can assume that any lap with a pace above 10 minutes_per_mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally short records where the total elapsed time is one minute or less.

tyler_running_filter_pace <- tyler_running %>% 
  filter(minutes_per_mile <=10 & minutes_per_mile>=5 & total_elapsed_time_s>1)

#Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.

tyler_running_group_time <- tyler_running_filter_pace %>% 
  mutate(time_period = case_when(
    year %in% 2024 & month %in% c(1:6) ~ "Jan-June",
    year %in% 2024 & month %in% c(7:12) ~ "July-Present",
    year <= 2023 ~ "pre-2024",
    is.na(year) ~ NA_character_,
    TRUE ~ "NA"
  ))

#Make a scatter plot that graphs SPM over speed by lap.
#unclear what "speed by lap" is - "minutes per mile"?

ggplot(data = tyler_running_group_time, aes(x= minutes_per_mile, y= steps_per_minute)) +
  geom_point()

#Make 5 aesthetic changes to the plot to improve the visual.
ggplot(data = tyler_running_group_time, aes(x= minutes_per_mile, y= steps_per_minute)) +
  geom_point(alpha = 0.2)+
  geom_smooth()+
  ylab("Steps per Minute (SPM)") + xlab("Speed (Minutes per Mile)")+#title and labels
  theme_classic()+
  ggtitle("SPM and Speed") +
  theme(
    plot.title = element_text(hjust = 0.5) # Center the title
  )
 

#Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth())
ggplot(data = tyler_running_group_time, aes(x= minutes_per_mile, y= steps_per_minute, color = time_period)) +
  geom_point(alpha = 0.1)+
  geom_smooth()+
  theme_classic()+
  ylab("Steps per Minute (SPM)") + xlab("Speed (Minutes per Mile)")+#title and labels
  ggtitle("SPM and Speed")+
  theme(
    plot.title = element_text(hjust = 0.5) # Center the title
  )

#Does this relationship maintain or break down as Tyler gets tired? Focus just on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap numbers, assuming that all laps on a given day correspond to the same run (hint: check out the rank() function). Select only laps 1-3 (Tyler never runs more than three miles these days). Make a plot that shows SPM, speed, and lap number (pick a visualization that you think best shows these three variables).

?rank()

post_intervention_runs <- tyler_running_group_time %>% 
  filter(time_period == "July-Present") 
  mutate(
    date = as.Date(timestamp),                     
    lap = rank(timestamp, ties.method = "first"),   
    lap = case_when(lap > 3 ~ NA_integer_,          
                    TRUE ~ lap)
  ) %>%
  filter(!is.na(lap)) # STOPPED HERE - need to work out the code above (only provided laps for one day- not laps for every day) 
  
