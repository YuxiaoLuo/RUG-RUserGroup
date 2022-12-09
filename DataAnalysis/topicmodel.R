########################################
# Analyze text data
# LDA Topic modeling 
# Yuxiao Luo

library(tidyverse)
library(quanteda)
library(topicmodels)

lyrics <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/genius.csv")

lyrics %>% select(artist_name) %>% unique()

lyrics %>% filter(artist_name == 'Full of Hell') 

# extract observations from artist Buck Meek
txt <- lyrics %>% filter(artist_name == 'Buck Meek') 

# LDA topic model (ML) Latent Dirichlet allocation
# unsupervised learning, exract features/variables from the dataset
library(quanteda) # text analysis, preprocessing techniques, doc-feature-matrix
library(tm) # text mining, text analysis, doc-term-matrix 

txt_corpus <- corpus(txt, text_field = "line")

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

# selection process (optional)
#dfm_trim(DFM, min_docfreq = 20)
#dfm_trim(DFM, max_docfreq = 0.99, docfreq_type = 'prop')

# convert dfm to dtm for topic model
DTM <- convert(DFM, to = 'tm')

# LDA topic model
library(topicmodels)
# Gibbs sampling
result <- LDA(x = DTM, k = 5, method = 'Gibbs', control = list(seed = 1234))
result

library(tidytext)
topics <- tidy(result, matrix = 'beta')
topics %>% head

# visualize 
top_terms <- topics %>% group_by(topic) %>% top_n(20, beta) %>% 
  ungroup() %>% 
  arrange(topic, -beta)

# graph
top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free_y") +
  coord_flip()









