#notes 
#bracket & and | statements in parentheses (R thinks of & as multiply and | as addition) it will calculate & before | unless put in parentheses 
#() and {} are the same thing 

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

#one plot, one purpose - similar to one paragraph one function 

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
  stat_smooth(method = "lm") #lm = linear model (linear regression), difference b/w stat_smooth and geom smooth? 

#Now I've instead added LOESS trendcurves for each color (can be more accurate than lm) #you can make LOESS curves more or less sensitive 
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

#Jet vs Turbo - Turbo much more uniform 

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
  scale_fill_brewer(palette = "PuRd") #instead of scale_fill_viridis we use scale_fill_brewer - look at list of options from earlier / below
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

ggplot(iris, aes(x= Sepal.Length, y= Petal.Length, color = Species)) +
  geom_point() + theme_classic() + 
  ggtitle("Sepal and Petal Length of Three Iris Species") + 
  scale_color_manual(values = cbPalette) + #inserted cbPalette 
  xlab("Sepal Length in cm") + 
  ylab("Petal Length in cm")

##DIVERGING DISCRETE----
#from RColorBrewer
myiris <- iris %>% group_by(Species) %>% mutate(size = case_when(
  Sepal.Length > 1.1* mean(Sepal.Length) ~ "very large",
  Sepal.Length < 0.9 * mean(Sepal.Length) ~ "very small",
  Sepal.Length < 0.94 * mean(Sepal.Length) ~ "small",
  Sepal.Length > 1.06 * mean(Sepal.Length) ~ "large",
  T ~ "average"
  
))
myiris$size <- factor(myiris$size, levels = c(
  "very small", "small", "average", "large", "very large"
)) #manually setting levels 

ggplot(myiris, aes(x= Petal.Width, y= Petal.Length, color = size)) +
  geom_point(size = 2) + theme_gray() +
  ggtitle("Diamond Quality by Cut") + 
  scale_color_brewer(palette = "RdYlBu")

#Paul Tol also has developed qualitative, sequential, and diverging colorblind palettes:
#https://cran.r-project.org/web/packages/khroma/vignettes/tol.html
#you can enter the hex codes in manually just like the cbPalette example above


#also check out the turbo color palette!
#https://docs.google.com/presentation/d/1Za8JHhvr2xD93V0bqfK--Y9GnWL1zUrtvxd_y9a2Wo8/edit?usp=sharing
#https://blog.research.google/2019/08/turbo-improved-rainbow-colormap-for.html

#to download it and use it in R, use this link
#https://rdrr.io/github/jlmelville/vizier/man/turbo.html

#Section 3: Non-visual representations ####
#Braille package

#Section 4: Publishing Plots and Saving Figures & Plots ####
library(cowplot)
#you can print multiple plots together, 
#which is helpful for publications
# make a few plots:

plot.diamonds <- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5))
#plot.diamonds

plot.cars <- ggplot(mpg, aes(x = cty, y = hwy, colour = factor(cyl))) + 
  geom_point(size = 2.5)
#plot.cars

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species)) +
  geom_point(size=3, alpha=0.7, shape=21)
#plot.iris

# use plot_grid #linking plots together 
panel_plot <- plot_grid(plot.cars, plot.iris, plot.diamonds, 
                        labels=c("A", "B", "C"), ncol=2, nrow = 2)

panel_plot

#you can fix the sizes for more control over the result #ggdraw function
fixed_gridplot <- ggdraw() + draw_plot(plot.iris, x = 0, y = 0, width = 1, height = 0.5) +
  draw_plot(plot.cars, x=0, y=.5, width=0.5, height = 0.5) +
  draw_plot(plot.diamonds, x=0.5, y=0.5, width=0.5, height = 0.5) + 
  draw_plot_label(label = c("A","B","C"), x = c(0, 0.5, 0), y = c(1, 1, 0.5))

fixed_gridplot

#saving figures----

ggsave("data_output/gridplot.png", fixed_gridplot) #always use ggsave instead of save image so you can make edits 
#you can save images as .png, .jpeg, .tiff, .pdf, .bmp, or .svg

#for publications, use dpi of at least 700
ggsave("data_output/gridplot.png", fixed_gridplot, 
       width = 6, height = 4, units = "in", dpi = 700)

#interactive web applications
installed.packages(plotly)
library(plotly)

plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, 
                                   fill=Species)) +
  geom_point(size=3, alpha=0.7, shape=21)

plotly::ggplotly(plot.iris)
