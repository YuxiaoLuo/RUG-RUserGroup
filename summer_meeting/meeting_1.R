###########################
# RUG Summer Meeting 2022
# 07/01/2022

# load the package 
library(tidyverse)

# pipe in operator
# Ctrl+Shift +M
# %>% operator in magrittr in tidyverse

# first few rows in dataset
# you can specify how many rows you want to see 
head(ggplot2::mpg, 20)
class(ggplot2::mpg)

ggplot2::mpg %>% head()

# check every column in dataset
ggplot2::mpg %>% glimpse()

# check the data description
?mpg

# assgin this data to an object called mpg_data
mpg_data <- mpg 

# load data into R
data(mpg)

# create ggplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))


vec_color <-  c('black', 'red', 'pink', 'blue', 'brown', 'green', 'yellow')

# adding customized color using scale_color_manual
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) + 
  scale_color_manual(values = vec_color)

# Q1:
# when to put aesthetics in the ggplot function

# change the dot size in the plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = cyl))

# change transparency of the points
vec_alpha = seq(1, 10, 1.5)

# change the alpha (transparency) for all the points
# alpha is outside mapping argument
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), alpha = 0.2)

# change color for all the points
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), color = 'red', alpha = .2)

# creating differences for the points in different classes
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Facets 
# facet_wrap()

# visualize points in single plot based on the categorical variables
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# facet_grid()
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)



# line type
# geom_smooth()
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# using color in the legend
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
              show.legend = FALSE)

# do points and lines at the same time
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth() + 
  geom_point(mapping = aes(color = class))

# filter to select a specific kind of category from the variable 
# se: standard error
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = TRUE)

# bar plot
# geom_bar()

# load the data: diamonds 
data(diamonds)
?diamonds
diamonds %>% glimpse()

# visualize in bar plot
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# add some customization 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, color = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# in ggplot2, there are some built-in color palette 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity)) + 
  theme_classic()




