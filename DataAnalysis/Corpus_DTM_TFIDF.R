########################################
# Analyze text data
# DTM, Frequency, TF-IDF 
# Yuxiao Luo
# 

library(tidyverse)
library(tm) # text mining

# read the csv data from github repo
lyrics <- read_csv("https://raw.githubusercontent.com/YuxiaoLuo/r_analysis_dri_2022/main/data/genius.csv")

glimpse(lyrics)

# combine lines of lyrics for each song
# remove unnecessary columns
lyrics <- lyrics %>% group_by(song_name) %>% 
  mutate(song_lyrics = str_c(line, collapse = ' '), .before = line) %>% 
  select(-section_name,-section_artist,-line,-line_number) %>% distinct()

# see how many song each artist has
lyrics %>% group_by(artist_name) %>% count()

# corpus: a collection of documents, think of as a data structure  
# create a corpus of lyrics
my_corpus <- VCorpus(VectorSource(lyrics$song_lyrics))
my_corpus

meta(my_corpus)

# Corpus Transformation
# remove numbers, remove punctuation, remove words
# stem document, strip white space

my_corpus <- tm_map(my_corpus, removePunctuation)
my_corpus <- tm_map(my_corpus, removeNumbers)
my_corpus <- tm_map(my_corpus, removeWords, stopwords::stopwords('en'))

# transform to lower case (need to wrap in content_transformer)
my_corpus <- tm_map(my_corpus, content_transformer(tolower))
my_corpus <- tm_map(my_corpus, stripWhitespace)

# check the the processed words in first document
my_corpus[[1]]$content
head(strwrap(my_corpus[[1]]), 15)

# stem the words if you want
stem_corpus <- tm_map(my_corpus, stemDocument)
head(strwrap(stem_corpus[[1]]), 15)

# you can replace all the words if you find some stemmed words not readable
tm_map(stem_corpus, content_transformer(str_replace_all), 
       pattern = 'babi', replacement = 'baby')[[1]]$content

# Document Term Matrix
dtm <- DocumentTermMatrix(my_corpus)
inspect(dtm)

# sparsity: refers to the terms that appear in only one document 
# in this document term matrix, 1190 out of 17818 words appear in only
# one document

# transform DTM to tidy format
words_frequency <- tidy(dtm)
# calculate frequency for each word regardless documents
words_frequency <- words_frequency %>% 
  group_by(term) %>% 
  mutate(freq = sum(count)) %>% 
  select(-document,-count) %>% 
  ungroup() %>% 
  distinct() %>% 
  arrange(-freq)

words_frequency

# another function find terms with frequency specified
findFreqTerms(dtm, lowfreq = 16, highfreq = 23)

# find words that correlated with 'love' with a coefficient > .70
findAssocs(dtm, 'love', .70) %>% data.frame()

# TF:IDF
# change the weight from term frequency to term frequency-inversed document frequecy
dtm_tfidf <- DocumentTermMatrix(my_corpus, control = list(
  weighting = weightTfIdf
))

dtm_tfidf

# Visualize the term tfidf
df <- tidy(dtm)
df

# create dataset for plotting 
# create category by artist 
df_plot <- bind_tf_idf(df, term = term, document = document, n = count) %>% 
  arrange(desc(tf_idf)) %>% 
  mutate(word = factor(term, levels = rev(unique(term))),
         artist = ifelse(as.numeric(document)>11,'Full of Hell','Buck Meek')) %>% 
  group_by(document) %>% 
  slice_max(n = 1, order_by = tf_idf) %>% ungroup()

# plot
df_plot %>% ggplot(aes(word, tf_idf, fill = document))+
  geom_bar(stat = "identity", alpha = .8, show.legend = FALSE) +
  facet_wrap(~artist, ncol = 2, scales = "free") +
  coord_flip()

 