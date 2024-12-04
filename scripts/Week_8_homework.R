#Let’s look at some real data from Mauna Loa to try to format and plot. These meteorological data from Mauna Loa were collected every minute for the year 2001. This dataset has 459,769 observations for 9 different metrics of wind, humidity, barometric pressure, air temperature, and precipitation. 

library(tidyverse)
library(ggplot2)

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

#Use the README file associated with the Mauna Loa dataset to determine in what time zone the data are reported, and how missing values are reported in each column.
#BRW = UTC+9, MLO = UTC+10, SMO = UTC+11, SPO = UTC - 12

#With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s
mloa_clean <- mloa %>% 
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9)

# Generate a column called “datetime” using the year, month, day, hour24, and min columns.
str(mloa_clean)

mloa_clean$year <- as.character(mloa_clean$year)
mloa_clean$month <- as.character(mloa_clean$month)
mloa_clean$day <- as.character(mloa_clean$day)
mloa_clean$hour24 <- as.character(mloa_clean$hour24)
mloa_clean$min <- as.character(mloa_clean$min)

#generate column 
mloa_clean$datetime <- ymd_hm(paste0(mloa_clean$year, "-", mloa_clean$month,
                        "-", mloa_clean$day, ", ", mloa_clean$hour24, ":",
                        mloa_clean$min, sep = ""), tz = "UTC")

#Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()).

?with_tz

mloa_clean_date_time <- mloa_clean %>% 
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))
  


#another way to do this:
mloa2 = mloa %>%
  # Remove NA's
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>%
  # Create datetime column (README indicates time is in UTC)
  mutate(datetime = ymd_hm(paste0(year,"-", 
                                  month, "-", 
                                  day," ", 
                                  hour24, ":", 
                                  min), 
                           tz = "UTC")) %>%
  #Convert to local time
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))

# if you use paste it automatically puts spaces 
#if you use paste0 it removes the spaces and puts dashes 
#you can specify "sep" at the end (means seperator) sep = '-'
#another way to do it: 
mloa2 %>% mutate(datetime = ymd_hm(paste(year,month,day,sep='-'), paste(hour24, min, sep=':')))


#Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()).

?month()
?hour()

mloa_summaraize <- mloa_clean_date_time %>%
  # Extract month and hour from local time column
  mutate(localMon = month(datetimeLocal, label = TRUE),
         localHour = hour(datetimeLocal)) %>%
  # Group by local month and hour
  group_by(localMon, localHour) %>%
  # Calculate mean temperature
  summarize(meantemp = mean(temp_C_2m)) 

#summarize collapses the data table into the means you ask for, mutate returns a mean for every value (I think)



#Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.
ggplot(data = mloa_summaraize, mapping = aes(x = localMon, y = meantemp)) + 
  geom_point(aes(color = localHour))+ #defaults to continuous color scheme when you put in numbers 
  scale_color_viridis_c(labs(title = "Local Hour")) +
  # Label axes, add a theme
  xlab("Month") +
  ylab("Mean temperature (degrees C)") +
  theme_classic()


?viridis
