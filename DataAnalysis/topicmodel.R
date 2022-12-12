########################################
# Analyze text data
# LDA Topic modeling 
# Yuxiao Luo

library(tidyverse)
library(quanteda)
library(topicmodels)

lyrics <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/genius.csv")

lyrics %>% select(artist_name) %>% unique()

lyrics %>% filter(artist_name == 'Full of Hell') %>% select(song_name) %>% unique()

# idea: we want to compare lyrics between 2 artists 
# see what topics each one foucses on 

# remove unrelevant columns
lyrics <- lyrics %>% select(-section_name, -section_artist, -line_number)

# combine lines of lyrics for 1 song for each artist
lyrics <- lyrics %>% group_by(song_name) %>% 
  mutate(txt = str_c(line,collapse = ' '), .before = line) %>% 
  select(-line)

# remove repetitive observations
lyrics <- distinct(lyrics)

BM <- lyrics %>% filter(artist_name == 'Buck Meek')
FH <- lyrics %>% filter(artist_name == 'Full of Hell')
# LDA topic model (ML) Latent Dirichlet allocation
# unsupervised learning, exract features/variables from the dataset
library(quanteda) # text analysis, preprocessing techniques, doc-feature-matrix
library(tm) # text mining, text analysis, doc-term-matrix 

# check Buck Meek's songs first
song <- BM

# check Full of Hell's songs
song <- FH

txt_corpus <- corpus(song, text_field = "txt")

# create tokens without preprocessing 
txt_corpus <- tokens(txt_corpus)

# create tokens with preprocessing jobs (cleaning)
txt_corpus <- tokens(txt_corpus,
       remove_punct = TRUE,
       remove_numbers = TRUE,
       remove_separators = TRUE)

# remove stopwords
library(stopwords)
stopwords::stopwords('en')
txt_corpus <- tokens_select(txt_corpus, stopwords::stopwords('en', source = 'snowball'), 
              selection = 'remove')
# create DFM
DFM <- dfm(txt_corpus, tolower = TRUE)
DFM

# remove the songs where all words are stopwords
dfm_subset(DFM, ntoken(DFM)>0)
# selection process (optional)
#dfm_trim(DFM, min_docfreq = 20)
#dfm_trim(DFM, max_docfreq = 0.99, docfreq_type = 'prop')

# remove the text files that all features are 0
DFM <- dfm_subset(DFM, ntoken(DFM)>0)
  
# convert dfm to dtm for topic model
DTM <- convert(DFM, to = 'tm')
inspect(DTM)

# LDA topic model
library(topicmodels)
# Gibbs sampling
result <- LDA(x = DTM, k = 3, method = 'Gibbs', control = list(seed = 1234))
result

library(tidytext)
topics <- tidy(result, matrix = 'beta')
topics %>% head

# visualize 
top_terms <- topics %>% group_by(topic) %>% top_n(10, beta) %>% 
  ungroup() %>% 
  arrange(topic, -beta)

# graph for Buck Meek's songs
BM_topic <- top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free_y") +
  coord_flip()

# graph for Full of Hell's songs
FH_topic <- top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free_y") +
  coord_flip()
