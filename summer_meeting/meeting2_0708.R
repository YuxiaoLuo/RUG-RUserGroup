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
# we want to set the x-axis limits
ggplot(diamonds, aes(x = z, y = price, color = clarity)) + 
  geom_point() + 
  coord_cartesian(xlim = c(0,10))

# coord_cartesian(xlim = NULL, ylim = NULL, 
# expand = TRUE, default = FALSE, clip = “on)

# change colors manually 
# scale_fill_manual()
# scale_color_manual()

# RColorBrewer palettes





















