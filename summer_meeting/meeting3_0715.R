#######################
# 0715/2022
# Regression Analysis
#######################

# data wrangling
library(tidyverse)
# managing file path
library(here)
# exploratory analysis
library(GGally)
# regression
library(leaps)

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
lm_spo <- lm(energy ~ tempo + loudness, spo)

lm_spo

# regression table 
summary(lm_spo)



