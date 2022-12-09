#####################################################
# RUG - Confidence intervals and hypothesis testing
# Yuxiao Luo
# 2022 Fall 

######################
# concepts refresher: https://www.khanacademy.org/math/statistics-probability

library(tidyverse)

# Normal distribution pdf (probability density function)
dnorm(0)
# Normal distribution cdf (cumulative density function)
pnorm(0)

######################
# one normal mean 

x <- c(1,4,2,3,6,9,1,3,9,3)
x_norm <- rnorm(10, mean = 0 ,sd = 1)

qplot(x)
qplot(x_norm)

# reject null hypothesis -> true mean is not equal to 0
t.test(x, conf.level = .99)

# accept null hypothesis -> true mean is equal to 0
t.test(x_norm, conf.level = .99)

# output T-test table
library(broom) # to use tidy()

# output 
# csv file is exported to the folder named output
t.test(x, conf.level = .99) %>% 
  tidy() %>%  
  rename(Variable = estimate, 
         Sample_Mean = estimate, 
         t_statistic = statistic,
         df = parameter) %>% 
  write_csv("output/Ttest.csv")

# we can change conf.level to any confidence level (default is .95) 
# change it to .99
t.test(x, conf.level = .99)

###################################
# Change hypothesis
# Previous hypothesis: H0: mu = 0 against H1: mu != 0
# 1. We can change hypothesized value under the null to some value not 0 
#   by changing argument "mu" of t.test to another number
# 2. We can change the alternative from "two.sided" to "less than" or "greater than"
#   by changing "alternative" to "less" or "greater"

# H0: mu = 5 against mu != 5
t.test(x, mu = 5, alternative = 'less')


#################################
# 2 independent normal means

# data: A sample of 40 individuals 
# 20 of them assigned to new treatment
# 20 of them the current treatment 
# Scale of outcome: 0 - 100. 0 means bad, 100 means good. 

# read the csv data in data folder
pharma <- read_csv('data/pharma.csv')

summary(pharma)

# boxplot of 2 groups
ggplot(pharma, aes(x = group, y = outcome)) + geom_point() + geom_boxplot()

# histogram of outcomes 
ggplot(pharma) + aes(x = outcome) + geom_histogram()

# histograms of outcomes by groups
# use facet_grid()

ggplot(pharma) + 
  aes(x = outcome) +
  geom_histogram() + 
  facet_grid(group ~.)

# Q: if the population menas of health outcomes are different at 
# significance level of 1%
phar_test <- t.test(outcome ~ group, conf.level = .99, data = pharma)
phar_test

# generate the Hypothesis table
phar_test %>% 
  tidy() %>% 
  rename(Variable = estimate, 
         Mean_Current = estimate1, 
         Mean_New = estimate2,
         t_statistic = statistic,
         df = parameter) %>% 
  mutate(Variable = "Group")

# Conclusion:
# 1. Treatments significantly different at 0.01 significance level
# 2. Not recommend new drug, new treatment significantly worse than current one

###############################
# One proportion 
# https://vicpena.github.io/sta9750/basicinference.pdf










