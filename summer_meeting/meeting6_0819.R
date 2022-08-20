###########################################
# RUG meeting 
# Regression Modeling 
# 08/19/2022

library(tidyverse)
library(GGally)
# model selection
library(leaps)

# dataset: NYC restaurant dataset in Sheather (2009)
# 150 Italian restaurants in Manhattan 
nyc <- read_csv('https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/nyc.csv')

nycplot <- nyc %>% select(-Case, -Restaurant, -East)
GGally::ggpairs(nycplot)

# construct model
lm_nyc <- lm(Price ~ Food + Decor + Service + East, data = nyc)
summary(lm_nyc)

#####################
# Backward selection 

# Backward selection: step() in stats package
# Performance measure: AIC (Akaike Information Criterion)

step(lm_nyc, direction = 'backward')

# Forward selection
# create a null model 
nullnyc <- lm(Price ~ 1, data = nyc) # no variables in the model
# starting model (no vars in)
# full model (every var is inlcuded)
fwd <- step(nullnyc, 
            scope = list(upper = lm_nyc),
            direction = 'forward')

# stepwise regression
lm2_nyc <- lm(Price ~ Service, data = nyc)
step(lm2_nyc, 
     scope = list(lower = lm2_nyc, upper = lm_nyc),
     direction = 'both')

# BIC 
# k = log(n) in the step() --> argument name in step()
# n: # of observations in the dataset
# BIC = log(N) * k -2 * LL  --> k refers to # of parameters, N refers to # of observations
# AIC = 2 * K – 2 * LL --> k refers to # of parameters

n <- nrow(nyc)
step(lm_nyc, direction = 'backward', k = log(n))

#################
# leaps 
library(leaps)
# adjusted R-squared
allsubs <- regsubsets(Price ~ Food + Decor + Service + East, data = nyc)
summary(allsubs)

plot(allsubs)

# use adjusted R-squared as performance measure
plot(allsubs, scale = 'adjr')
