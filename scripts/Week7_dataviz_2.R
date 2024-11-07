library(tidyverse)
library(ggplot2)

#Section 1: Plot Best Practices and GGPlot Review----
#ggplot has four parts:
#data / materials   ggplot(data=yourdata)
#plot type / design   geom_...
#aesthetics / decor   aes()
#stats / wiring   stat_...

#Let's see what this looks like:

#Here we practice creating a dot plot of price on carat
ggplot(data = diamonds, aes(x= carat, y= price)) +
  geom_point()

#Remember from Part 1 how we iterate? 
#I've added transparency and color

#all-over color
ggplot(data = diamonds, aes(x= carat, y= price)) +
  geom_point(color="blue")
#color by variable 
ggplot(data = diamonds, aes(x= carat, y= price, color=clarity)) + #clarity is a variable in the diamonds dataframe. if you want to color by a variable then that has to go under the aes command and not separately 
  geom_point(alpha = 0.2) #alpha increases transparency 

#plot best practices:
#remove backgrounds, redundant labels, borders, 
#reduce colors and special effects unless it has specific purpose #if we have carat on x axis we don't also want to assing colors to carats b/c that is redundant use of the data 
#remove bolding, lighten labels, remove lines, direct label

#Now I've removed the background to clean up the plot
#As we learned last week, there are other themes besides classic. Play around!
ggplot(diamonds, aes(x= carat, y= price, color=clarity)) +
  geom_point(alpha = 0.2) + 
  theme_classic() #direct labeling also useful in some situations 

#keep your visualization simple with a clear message
#label axes
#start axes at zero

#Now I've added a title and edited the y label to be more specific
ggplot(diamonds, aes(x= carat, y= price, color=clarity)) +
  geom_point(alpha = 0.2) + theme_classic() + 
  ggtitle("Price by Diamond Quality") + ylab("price in $") #title and labels

#Now I've added linear regression trendlines for each color
ggplot(diamonds, aes(x= carat, y= price, color=clarity)) +
  geom_point(alpha = 0.2) + theme_classic() + 
  ggtitle("Price by Diamond Quality") + ylab("price in $") + 
  stat_smooth(method = "lm") #lm = linear regression, difference b/w stat_smooth and geom smooth? 

#Now I've instead added LOESS trendcurves for each color (can be more accurate than lm)
ggplot(diamonds, aes(x= carat, y= price, color=clarity)) +
  geom_point(alpha = 0.2) + theme_classic() + 
  ggtitle("Price by Diamond Quality") + ylab("price in $") + 
  stat_smooth(method = "loess") #lines will cut off early if there's not enough data 

#Go to the Tutorials > Data Visualization Part 1 for a refresher on how to use
#colors in geom_line (a time series)

#Section 2 Color Palette Choices and Color-Blind Friendly Visualizations ####

#if you use gradients of colors want to make sure you're not distorting the data - evenness of scale 
#if you use color, can your plots still be interpreted when printed in black & white 

#I use the colorpalette knowledge I learned from R-DAVIS every time I make a plot,
#and it's not an exaggeration to say that it changed my life!
#Here are some templates that you may use and edit in your own work.

#There are four types of palettes: 
#1: continuous
#2: ordinal (for plotting categories representing least to most of something, with zero at one end)
#3: qualitative (for showing different categories that are non-ordered)
#4: diverging (for plotting a range from negative values to positive values, with zero in the middle)

#RColorBrewer shows some good examples of these. Let's take a look.
library("RColorBrewer")
#This is a list of all of RColorBrewer's colorblind-friendly discrete color palettes 
display.brewer.all(colorblindFriendly = TRUE)
#top type is for continuous 
#second section good for ordinal
#third section good for diverging 

##CONTINUOUS DATA----
#use scale_fill_viridis_c or scale_color_viridis_c for continuous (viridis already loaded in R) 
#I set direction = -1 to reverse the direction of the colorscale.
ggplot(diamonds, aes(x= clarity, y= carat, color=price)) + #price is continuous 
  geom_point(alpha = 0.2) + theme_classic() +
  scale_color_viridis_c(option = "C", direction = #different options 
                          -1)#set direction 1 or -1 from dark to light 

#let's pick another viridis color scheme by using a different letter for option
ggplot(diamonds, aes(x= clarity, y= carat, color=price)) +
  geom_point(alpha = 0.2) + theme_classic() +
  scale_color_viridis_c(option = "E", direction = -1)

#to bin continuous data, use the suffix "_b" instead #i might want to do this?? 
ggplot(diamonds, aes(x= clarity, y= carat, color=price)) +
  geom_point(alpha = 0.2) + theme_classic() +
  scale_color_viridis_b(option = "C", direction = -1)

##ORDINAL (DISCRETE SEQUENTIAL) ----
#from the viridis palette
#use scale_fill_viridis_d or scale_color_viridis_d for discrete, ordinal data
ggplot(diamonds, aes(x= cut, y= carat, fill = color)) + #use fill to fill boxplot
  geom_boxplot() + theme_classic() + 
  ggtitle("Diamond Quality by Cut") + 
  scale_fill_viridis_d("color") #underscore d for discrete 

#scale_color is for color and scale_fill is for the fill. 
#note I have to change the
#aes parameter from "fill =" to "color =", to match
ggplot(diamonds, aes(x= cut, y= carat, color = color)) + #no it's outlined 
  geom_boxplot(alpha = 0.2) + theme_classic() + 
  ggtitle("Diamond Quality by Cut") + 
  scale_color_viridis_d("color")


#here's how it looks on a barplot
ggplot(diamonds, aes(x = clarity, fill = cut)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5)) +
  scale_fill_viridis_d("cut", option = "B") +
  theme_classic()

#from RColorBrewer:
ggplot(diamonds, aes(x= cut, y= carat, fill = color)) +
  geom_boxplot() + theme_classic() + 
  ggtitle("Diamond Quality by Cut") + 
  scale_fill_brewer(palette = "PuRd") #look at list of options from earlier / below
#how did we know the name of the palette is "PuRd"? From this list:
display.brewer.all(colorblindFriendly = TRUE)

##QUALITATIVE CATEGORICAL----
#use iris dataset with 3 different species 

ggplot(iris, 
       aes(x= Sepal.Length, y= Petal.Length, fill = Species)) +
  geom_point(shape=24, color="black", size = 4) + theme_classic() + #change shape to make point triangle instead of circle, color refers to outline color, change size of triangles 
  ggtitle("Sepal and Petal Length of Three Iris Species") + 
  scale_fill_brewer(palette = "Set2")
#how did we know the name of the palette is "Set2"? From this list:
display.brewer.all(colorblindFriendly = TRUE)

#From the ggthemes package:
#let's also clarify the units
library(ggthemes)
ggplot(iris, aes(x= Sepal.Length, y= Petal.Length, color = Species)) +
  geom_point() + theme_classic() + 
  ggtitle("Sepal and Petal Length of Three Iris Species") + 
  scale_color_colorblind("Species") + #from ggthemes 
  xlab("Sepal Length in cm") + 
  ylab("Petal Length in cm")

#Manual Palette Design
#this is another version of the same 
#colorblind palette from the ggthemes package but with gray instead of black.
#This is an example of how to create a named vector #use named vector to minimze errors 
#of colors and use it as a manual fill.
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
names(cbPalette) <- levels(iris$Species)
#we don't need all the colors in the palette because there are only 3 categories. 
#We cut the vector length to 3 here
cbPalette <- cbPalette[1:length(levels(iris$Species))]
