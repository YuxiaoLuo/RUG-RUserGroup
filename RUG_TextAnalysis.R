####################################
# Text Analysis

library(quanteda)
library(dplyr)
library(readr)

air <- read_csv("C:/Users/Yuxiao Luo/Documents/R/Workshop/RUG-RUserGroup/data/Airbnb.csv")
dict <- dictionary(file = "C:/Users/Yuxiao Luo/Documents/R/Workshop/RUG-RUserGroup/data/MFT.dic")

air.tokens <- tokens(air$comments,remove_punct = TRUE, remove_numbers = TRUE)
air.tokens <- tokens_wordstem(air.tokens)
air.tokens <- tokens_tolower(air.tokens)

air.dfm <- dfm(tokens_lookup(air.tokens, dictionary = dict))

air.moral <- convert(air.dfm, to = "data.frame")

dplyr::glimpse(air.moral)

air.moral <- air.moral[1:10000,]

head(air.moral)





































