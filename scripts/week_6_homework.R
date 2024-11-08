library(tidyverse)
gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") 
library(ggplot2)
#First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

new_gap <- gapminder %>% 
  group_by(continent, year) %>% 
  summarise(avg_life_expectancy = mean(lifeExp))
#didn't work to plot without using intermediate dataframes 
ggplot(data = new_gap, mapping = aes( x = year, y = avg_life_expectancy, color = continent))+
  geom_line()

#Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?
#Challenge! Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop), alpha = 0.5) + 
  scale_x_log10() + #puts x axis on logarithmic scale 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') + #adds in a trend line and specifies style 
  theme_bw()

#Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

gapminder %>% 
  filter(country %in% c("Brazil", "China", "El Salvador", "Niger", "United States")) %>% 
  count(country,lifeExp) %>% 
  ggplot(mapping = aes(x = country, y= lifeExp))+
  geom_jitter()+
  geom_boxplot(alpha = 0.3)+
  xlab("Country") + ylab("Life Expectancy") #change axis labels 


#also can write like this 
ggplot(data=gapminder[gapminder$country %in% c("Brazil", "China", "El Salvador", "Niger","United States"),] #put comma after column before bracket ends because it's taking x and y values from a vector (i think)

               