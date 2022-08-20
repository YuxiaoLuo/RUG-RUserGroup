#################################
# RUG Summer meeting 2022
# Regression modeling 
# Created: 08/12/2022

library(tidyverse)

# load nyc restaurant data in R
nyc <- read_csv('https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/nyc.csv')

# take a look at the data
glimpse(nyc)

# summary of statistics
summary(nyc)

# NAs, summary could show how many NAs
# this dataset doesn't have any NAs

# create a plot
nycplot <- nyc %>% select(-Case, -Restaurant, -East)

# for categorical variable, use histogram 
# calculate the frequency of each category
nyc %>% group_by(East) %>% count()

# use ggplot2 plotting functions
ggplot(nyc, aes(x = East)) + geom_histogram(stat = "count")

library(GGally)
ggpairs(nycplot)

# define the model 
# Response var: Price
# Predictor: Food, Decor, Service, East

lm_nyc <- lm(Price ~ Food + Decor + Service + East, data = nyc)
summary(lm_nyc)

par(mfrow = c(2,2))
plot(lm_nyc)

# remove the plots in the Plots window 
dev.off()

# multicollinearity 
car::vif(lm_nyc)

###################
# Cars data
library(caret)

# install.packages("caret")

# load the data from a built-in dataset
data(cars)

# take a look at the data
glimpse(cars)
help(cars)

summary(cars)

# Dependent var: Price
# Predictors: Mileage, Cylinder, Doors, Cruise
lm_cars <- lm(Price ~ Mileage + Cylinder + Doors + Cruise, data = cars)
summary(lm_cars)

# see AIC of the model
AIC(lm_cars)

BIC(lm_cars)







