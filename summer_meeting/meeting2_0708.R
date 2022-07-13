###########################
# RUG Summer Meeting 2022
# 07/08/2022

# question: when to set aes() in ggplot()?
# https://bookdown.dongzhuoer.com/hadley/ggplot2-book/aes.html
# 13.4.1 Specifying the aesthetics in the plot vs. in the layers

# example
ggplot(mpg, aes(displ, hwy, color = class)) + 
  geom_point()

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class))


ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = class)) + 
  geom_smooth(aes(color = 'loess'), method = 'loess', se = FALSE)
  
# if you set color manually put color in second layer
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(color = 'darkblue')

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(color = 'darkblue')

# if you want apperance to be goverend by a var, use aes()
# if you want override the default size or color put value outside of aes()

# if you put color inside aes(), it's creating a new var containing the 
# value 'darkblue' and scales it with a color scale
# the default color scale uses evenly spaced colors on the color wheel
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = 'darkblue'))

# you can map the value, but override the default scale
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(colour = "darkblue")) + 
  scale_colour_identity()

# load package 
library(tidyverse)

# visualize the 2 discrete vars in 2 categories
ggplot(data =diamonds, mapping = aes(x = carat, y = price)) + 
  geom_point() + 
  facet_grid(cut ~ color)

# if you have only one categorical vars with many levels
# use facet_wrap
ggplot(data =diamonds, mapping = aes(x = carat, y = price)) + 
  geom_point() + facet_wrap(~ cut, nrow = 2)

# in ggplot2, there are some built-in themes for the plots
# can use theme_ + tab to explore
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) + 
  theme_classic()

###################
# ggplot2 colors
# Reference: http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually

glimpse(diamonds)

ggplot(data =diamonds, mapping = aes(x = cut, fill = clarity)) + geom_bar()

ggplot(diamonds, aes(x = table, y = cut)) + 
  geom_boxplot(fill = '#A4A4A4', color = 'darkred')

ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point(color = 'darkblue')

# assign color by levels of cut
ggplot(diamonds, aes(x = carat, y = price, color = cut)) + 
  geom_point()

# assign color by levels of cut
ggplot(diamonds, aes(x = z, y = price, color = clarity)) + 
  geom_point()

# since there is one outlier affecting overall plot
# we want to set the x-axis limits using coord_cartesian()
ggplot(diamonds, aes(x = z, y = price, color = clarity)) + 
  geom_point() + 
  coord_cartesian(xlim = c(0,10))

# coord_cartesian(xlim = NULL, ylim = NULL, 
# expand = TRUE, default = FALSE, clip = “on)

# change colors manually 
# scale_fill_manual() for bars
# scale_color_manual() points

# website to find color code: https://www.rapidtables.com/web/color/RGB_Color.html
ggplot(diamonds, aes(x = z, y = price, color = clarity)) + 
  geom_point() + 
  coord_cartesian(xlim = c(0,10)) + 
  scale_color_manual(values = c("#999999", 
                               "#E69F00", 
                               "#56B4E9", 
                               "#FF00FF", 
                               "#008000",
                               "#B22222",
                               "#228B22",
                               "#2F4F4F"))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) + 
  scale_fill_manual(values = c("#999999", 
                               "#E69F00", 
                               "#56B4E9", 
                               "#FF00FF", 
                               "#008000",
                               "#B22222",
                               "#228B22",
                               "#2F4F4F"))

# argument breaks can change order of levels in legend
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity)) + 
  scale_fill_manual(values = c("#999999", 
                               "#E69F00", 
                               "#56B4E9", 
                               "#FF00FF", 
                               "#008000",
                               "#B22222",
                               "#228B22",
                               "#2F4F4F"),
                    breaks = c("IF", 
                               "VVS1", 
                               "VVS2",
                               "VS1",
                               "VS2",
                               "SI1",
                               "SI2",
                               "I1"))

##########################
# RColorBrewer palettes
# R package: RColorBrewer
# pre-defined color combination ready for use

db <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

dp <- ggplot(data = diamonds) + 
  geom_point(aes(x = z, y = price, color = clarity)) + 
  coord_cartesian(xlim = c(0,10))

# bar plot using RColorBrewer
db + scale_fill_brewer(palette = "Dark2")
db + scale_fill_brewer(palette = "Greens")
db + scale_fill_brewer(palette = "Blues")
db + scale_fill_brewer(palette = "YlGnBu")
db + scale_fill_brewer(palette = "YlGn")

dp + scale_color_brewer(palette = "Purples")
dp + scale_color_brewer(palette = "PuRd")

###############################################
# another package: Wes Anderson color palettes
# most palettes now only have 4 or 5 colors
# color schemes from: https://wesandersonpalettes.tumblr.com/
# install.packages("wesanderson")
library(wesanderson)

ggplot(data = mpg) + 
  geom_bar(aes(x = fl, fill = drv)) + 
  scale_fill_manual(values = wes_palette(n = 3, name = "Moonrise3"))

ggplot(data = mpg) + 
  geom_bar(aes(x = fl, fill = drv)) + 
  scale_fill_manual(values = wes_palette(n = 3, name = "Royal2"))

# use gray colors
db + scale_fill_grey() 
db + scale_fill_grey() + theme_classic()

# change gray value at low and high ends of the palette
db + scale_fill_grey(start = .8, end = .2) + theme_classic()

#############################
# continuous color

# scale_color_gradient(), scale_fill_gradient() -> sequential gradients between 2 colors
# scale_color_gradient2(), scale_fill_gradient2() -> diverging gradients
# scale_color_gradientn(), scale_fill_gradientn() -> gradient between n colors

dp <- ggplot(diamonds) + geom_point(aes(x = cut, y = z, color = price)) + 
  coord_cartesian(ylim = c(1, 7))

# continous color assigned automatically
dp

# sequential color scheme
dp + scale_color_gradient(low = 'blue', high = 'red')

# diverging color scheme
mid <- mean(diamonds$z)
dp + scale_color_gradient2(midpoint = mid, low = "blue", mid = "white", 
                           high = "red")


# gradient between n colors
dp + scale_color_gradientn(colors = rainbow(5))






























