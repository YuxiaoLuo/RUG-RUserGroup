#######################
# Regression Analysis
# created: 07/15/2022
# udpated: 07/22/2022
#######################

# data wrangling
library(tidyverse)
# managing file path
library(here)
# exploratory analysis
library(GGally)
# regression
library(leaps)

# read csv dataset from Github link
spo <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/spotify_lyrics.csv")

glimpse(spo)

# dbl: double type, float in Python
# int: integer, int in Python

# exploratory analysis 

# pairs: creates a scatterplot matrix for numeric vars
# select from dplyr package

# pipe operator %>%  
# Win: Ctrl+Shift+M
# Mac: Cmd+Shift+M

# remove genre, lyrics columns
head(spo)
spo_plot <- spo %>% select(-genre, -lyrics)
spo_plot <- select(spo, -genre, -lyrics)
head(spo_plot)

pairs(spo_plot)

summary(spo)

# ggpairs from GGally can do the same scatterplot matrix
# but in a nice formatted way
ggpairs(spo_plot)

# construct a linear regression 
# dependent var: energy 
# independent var: tempo, loudness

# construct a multiple regression model 
lm_spo <- lm(energy ~ tempo + loudness, spo)

lm_spo

# regression table 
summary(lm_spo)

###################
# diagnostic plots

# define the plotting matrix as 2x2
par(mfrow = c(2,2))
plot(lm_spo)

par(mfrow = c(1,4))
plot(lm_spo)

# par(mfrow(c(2,2))) is not comptiable ggplot2
# grid.arrange in ggplot2 can do the same thing

# Cook's distance to identify influential points
# Rule of thumb: 4/n 
cookd <- cooks.distance(lm_spo)
dev.off()
plot(cookd)
# add cutoff line
abline(h = 4/nrow(spo), lty = 2, col = 'red')

####################
# multicollinearity 
# check the correlations among the independent vars
# rule of thumb: vif value should be lower than 4
# if vif is between 4 and 10, still acceptable, but less preferred 
# if vis if larger than 10, very dangerous, reconsider it 
car::vif(lm_spo)














