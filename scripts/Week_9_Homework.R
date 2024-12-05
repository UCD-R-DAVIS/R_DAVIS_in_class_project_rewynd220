surveys <- read.csv("data/portal_data_joined.csv")
library(tidyverse)


#Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.

#basic syntax for for loops 
for(i in 1:10){ 
  print(i)
}

for(i in unique(surveys$taxa)) { #use unique because you don't need each taxa over and over again 
  taxa <- surveys %>% filter(taxa == i)
  myspecies <- unique(taxa$species)
  maxlength <- max(nchar(myspecies))
  print(taxa %>% filter(nchar(species) == maxlength) %>% 
    select(species) %>% unique ())

}

mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

#Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.

mloa_select <- mloa %>% 
  select(windDir, windSpeed_m_s,baro_hPa,temp_C_2m,temp_C_10m,temp_C_towertop,rel_humid, precip_intens_mm_hr) %>% 
  map(max, na.rm = TRUE) %>% 
  print()

#Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. 

c_to_f <- function(tempC){
  f <- ((tempC*1.8) + 32)
  return(f)
}

#Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Bonus: can you do this by using map_df? Don’t forget to name your new columns “temp_F…” and not “temp_C…”!



mloa$temp_F_2m <- c_to_f(mloa$temp_C_2m)
mloa$temp_F_10m <- c_to_f(mloa$temp_C_10m)
mloa$temp_F_towertop <- c_to_f(mloa$temp_C_towertop) #adding new column using dollar sign 

#another way to do the above coding 

mloa %>% mutate(temp_F_2m = c_to_f(temp_C_2m),
                temp_F_10m = c_to_f(temp_C_10m),
                temp_F_towertop = c_to_f(temp_C_towertop))

#Bonus- doing the same thing using map_df 

newmloa <- mloa %>% 
  select(temp_C_2m, temp_C_10m,temp_C_towertop) %>% 
  map_df(c_to_f) %>% 
  rename("temp_F_2m"="temp_C_2m", "temp_F_10m"="temp_C_10m", "temp_F_towertop"="temp_C_towertop") %>% 
  cbind(mloa) #function bind_cols and bind_rows

                
  
#Challenge: Use lapply to create a new column of the surveys dataframe that includes the genus and species name together as one string.

surveys %>% 
  mutate(genus_species = lapply(
    1:nrow(surveys), #(or use nrow - vector that goes from 1 to however many surveys there are)
    function(i){
      paste0(surveys$genus[i], " ", surveys$species[i])
    }
  ))
