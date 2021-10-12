---
title: "Strings_RUG"
author: "Yuxiao Luo"
date: "10/8/2021"
output: 
  html_document:
    keep_md: true
---



# Dealing with strings in R

There two popular packages to handle strings in R, one is `stringi` and the other is `stringr`. The comments from Hadley Wickham (author of the book [R for Data Science](https://r4ds.had.co.nz/)) saying:

- `stringi` provides tools to do anything we could ever want to do with strings, where `stringr` provides tools to do the most common 95% of operations. This allows `stringr` to be much simpler, and the cost of some flexibility.

- Additionally `stringi` is implemented in C using the ICU string library, so it's very fast and very correct (it deals with unicode better than base R).

`stringr` now is using `stringi` on the back end, so `stringr` will get all the performance benefits, and we can continue to use the simple interface. As these two packages have very similar syntax and function structures, switching between them are unimaginably easy. Let's take a look at the functions in `stringi` and `stringr`.


```r
library(stringi)
library(stringr)

# package version for stringi
packageVersion("stringi")
```

```
## [1] '1.5.3'
```

```r
# packag version for stringr
packageVersion("stringr")
```

```
## [1] '1.4.0'
```

```r
# functions in stringi
ls("package:stringi")
```

```
##   [1] "%s!=%"                         "%s!==%"                       
##   [3] "%s$%"                          "%s*%"                         
##   [5] "%s+%"                          "%s<%"                         
##   [7] "%s<=%"                         "%s==%"                        
##   [9] "%s===%"                        "%s>%"                         
##  [11] "%s>=%"                         "%stri!=%"                     
##  [13] "%stri!==%"                     "%stri$%"                      
##  [15] "%stri*%"                       "%stri+%"                      
##  [17] "%stri<%"                       "%stri<=%"                     
##  [19] "%stri==%"                      "%stri===%"                    
##  [21] "%stri>%"                       "%stri>=%"                     
##  [23] "stri_c"                        "stri_c_list"                  
##  [25] "stri_cmp"                      "stri_cmp_eq"                  
##  [27] "stri_cmp_equiv"                "stri_cmp_ge"                  
##  [29] "stri_cmp_gt"                   "stri_cmp_le"                  
##  [31] "stri_cmp_lt"                   "stri_cmp_neq"                 
##  [33] "stri_cmp_nequiv"               "stri_coll"                    
##  [35] "stri_compare"                  "stri_conv"                    
##  [37] "stri_count"                    "stri_count_boundaries"        
##  [39] "stri_count_charclass"          "stri_count_coll"              
##  [41] "stri_count_fixed"              "stri_count_regex"             
##  [43] "stri_count_words"              "stri_datetime_add"            
##  [45] "stri_datetime_add<-"           "stri_datetime_create"         
##  [47] "stri_datetime_fields"          "stri_datetime_format"         
##  [49] "stri_datetime_fstr"            "stri_datetime_now"            
##  [51] "stri_datetime_parse"           "stri_datetime_symbols"        
##  [53] "stri_detect"                   "stri_detect_charclass"        
##  [55] "stri_detect_coll"              "stri_detect_fixed"            
##  [57] "stri_detect_regex"             "stri_dup"                     
##  [59] "stri_duplicated"               "stri_duplicated_any"          
##  [61] "stri_enc_detect"               "stri_enc_detect2"             
##  [63] "stri_enc_fromutf32"            "stri_enc_get"                 
##  [65] "stri_enc_info"                 "stri_enc_isascii"             
##  [67] "stri_enc_isutf16be"            "stri_enc_isutf16le"           
##  [69] "stri_enc_isutf32be"            "stri_enc_isutf32le"           
##  [71] "stri_enc_isutf8"               "stri_enc_list"                
##  [73] "stri_enc_mark"                 "stri_enc_set"                 
##  [75] "stri_enc_toascii"              "stri_enc_tonative"            
##  [77] "stri_enc_toutf32"              "stri_enc_toutf8"              
##  [79] "stri_encode"                   "stri_endswith"                
##  [81] "stri_endswith_charclass"       "stri_endswith_coll"           
##  [83] "stri_endswith_fixed"           "stri_escape_unicode"          
##  [85] "stri_extract"                  "stri_extract_all"             
##  [87] "stri_extract_all_boundaries"   "stri_extract_all_charclass"   
##  [89] "stri_extract_all_coll"         "stri_extract_all_fixed"       
##  [91] "stri_extract_all_regex"        "stri_extract_all_words"       
##  [93] "stri_extract_first"            "stri_extract_first_boundaries"
##  [95] "stri_extract_first_charclass"  "stri_extract_first_coll"      
##  [97] "stri_extract_first_fixed"      "stri_extract_first_regex"     
##  [99] "stri_extract_first_words"      "stri_extract_last"            
## [101] "stri_extract_last_boundaries"  "stri_extract_last_charclass"  
## [103] "stri_extract_last_coll"        "stri_extract_last_fixed"      
## [105] "stri_extract_last_regex"       "stri_extract_last_words"      
## [107] "stri_flatten"                  "stri_info"                    
## [109] "stri_isempty"                  "stri_join"                    
## [111] "stri_join_list"                "stri_length"                  
## [113] "stri_list2matrix"              "stri_locale_get"              
## [115] "stri_locale_info"              "stri_locale_list"             
## [117] "stri_locale_set"               "stri_locate"                  
## [119] "stri_locate_all"               "stri_locate_all_boundaries"   
## [121] "stri_locate_all_charclass"     "stri_locate_all_coll"         
## [123] "stri_locate_all_fixed"         "stri_locate_all_regex"        
## [125] "stri_locate_all_words"         "stri_locate_first"            
## [127] "stri_locate_first_boundaries"  "stri_locate_first_charclass"  
## [129] "stri_locate_first_coll"        "stri_locate_first_fixed"      
## [131] "stri_locate_first_regex"       "stri_locate_first_words"      
## [133] "stri_locate_last"              "stri_locate_last_boundaries"  
## [135] "stri_locate_last_charclass"    "stri_locate_last_coll"        
## [137] "stri_locate_last_fixed"        "stri_locate_last_regex"       
## [139] "stri_locate_last_words"        "stri_match"                   
## [141] "stri_match_all"                "stri_match_all_regex"         
## [143] "stri_match_first"              "stri_match_first_regex"       
## [145] "stri_match_last"               "stri_match_last_regex"        
## [147] "stri_na2empty"                 "stri_numbytes"                
## [149] "stri_omit_empty"               "stri_omit_empty_na"           
## [151] "stri_omit_na"                  "stri_opts_brkiter"            
## [153] "stri_opts_collator"            "stri_opts_fixed"              
## [155] "stri_opts_regex"               "stri_order"                   
## [157] "stri_pad"                      "stri_pad_both"                
## [159] "stri_pad_left"                 "stri_pad_right"               
## [161] "stri_paste"                    "stri_paste_list"              
## [163] "stri_rand_lipsum"              "stri_rand_shuffle"            
## [165] "stri_rand_strings"             "stri_read_lines"              
## [167] "stri_read_raw"                 "stri_remove_empty"            
## [169] "stri_remove_empty_na"          "stri_remove_na"               
## [171] "stri_replace"                  "stri_replace_all"             
## [173] "stri_replace_all_charclass"    "stri_replace_all_coll"        
## [175] "stri_replace_all_fixed"        "stri_replace_all_regex"       
## [177] "stri_replace_first"            "stri_replace_first_charclass" 
## [179] "stri_replace_first_coll"       "stri_replace_first_fixed"     
## [181] "stri_replace_first_regex"      "stri_replace_last"            
## [183] "stri_replace_last_charclass"   "stri_replace_last_coll"       
## [185] "stri_replace_last_fixed"       "stri_replace_last_regex"      
## [187] "stri_replace_na"               "stri_reverse"                 
## [189] "stri_sort"                     "stri_sort_key"                
## [191] "stri_split"                    "stri_split_boundaries"        
## [193] "stri_split_charclass"          "stri_split_coll"              
## [195] "stri_split_fixed"              "stri_split_lines"             
## [197] "stri_split_lines1"             "stri_split_regex"             
## [199] "stri_startswith"               "stri_startswith_charclass"    
## [201] "stri_startswith_coll"          "stri_startswith_fixed"        
## [203] "stri_stats_general"            "stri_stats_latex"             
## [205] "stri_sub"                      "stri_sub_all"                 
## [207] "stri_sub_all_replace"          "stri_sub_all<-"               
## [209] "stri_sub_replace"              "stri_sub_replace_all"         
## [211] "stri_sub<-"                    "stri_subset"                  
## [213] "stri_subset_charclass"         "stri_subset_charclass<-"      
## [215] "stri_subset_coll"              "stri_subset_coll<-"           
## [217] "stri_subset_fixed"             "stri_subset_fixed<-"          
## [219] "stri_subset_regex"             "stri_subset_regex<-"          
## [221] "stri_subset<-"                 "stri_timezone_get"            
## [223] "stri_timezone_info"            "stri_timezone_list"           
## [225] "stri_timezone_set"             "stri_trans_char"              
## [227] "stri_trans_general"            "stri_trans_isnfc"             
## [229] "stri_trans_isnfd"              "stri_trans_isnfkc"            
## [231] "stri_trans_isnfkc_casefold"    "stri_trans_isnfkd"            
## [233] "stri_trans_list"               "stri_trans_nfc"               
## [235] "stri_trans_nfd"                "stri_trans_nfkc"              
## [237] "stri_trans_nfkc_casefold"      "stri_trans_nfkd"              
## [239] "stri_trans_tolower"            "stri_trans_totitle"           
## [241] "stri_trans_toupper"            "stri_trim"                    
## [243] "stri_trim_both"                "stri_trim_left"               
## [245] "stri_trim_right"               "stri_unescape_unicode"        
## [247] "stri_unique"                   "stri_width"                   
## [249] "stri_wrap"                     "stri_write_lines"
```

```r
# functions in stringr
ls("package:stringr")
```

```
##  [1] "%>%"             "boundary"        "coll"            "fixed"          
##  [5] "fruit"           "invert_match"    "regex"           "sentences"      
##  [9] "str_c"           "str_conv"        "str_count"       "str_detect"     
## [13] "str_dup"         "str_ends"        "str_extract"     "str_extract_all"
## [17] "str_flatten"     "str_glue"        "str_glue_data"   "str_interp"     
## [21] "str_length"      "str_locate"      "str_locate_all"  "str_match"      
## [25] "str_match_all"   "str_order"       "str_pad"         "str_remove"     
## [29] "str_remove_all"  "str_replace"     "str_replace_all" "str_replace_na" 
## [33] "str_sort"        "str_split"       "str_split_fixed" "str_squish"     
## [37] "str_starts"      "str_sub"         "str_sub<-"       "str_subset"     
## [41] "str_to_lower"    "str_to_sentence" "str_to_title"    "str_to_upper"   
## [45] "str_trim"        "str_trunc"       "str_view"        "str_view_all"   
## [49] "str_which"       "str_wrap"        "word"            "words"
```

Let's learn `stringr` first to get started with string manipulation in R. 

## Introduction to stringr

`stringr` is a R package for dealing with strings. There are 4 families of functions

- Character manipulation functions will allow you to create and change characters in the strings in character vectors

- whitespace tools to add, remove, and manipulate whitespace

- Locale sensitive operations whose operations will vary from locale to locale 

- Pattern matching functions. Ex., regular expressions, etc. 


### Dealing with individual characters

Let's load the package `stringr`


```r
library(stringr)
```

Let's take a look at the following functions: 
`str_length()` is equivalent to `nchar`, the base R function. 


```r
str_length('abc')
```

```
## [1] 3
```

```r
nchar('abc')
```

```
## [1] 3
```

```r
nchar(NA)
```

```
## [1] NA
```

```r
str_length(NA)
```

```
## [1] NA
```

`str_sub()` can subset a string and it takes 3 arguments: a character vector, a `start` position, and an `end` position. If the position is a positive integer, it will be counted from the left; if it's a negative integer, it will be counted from the right. The positions are inclusive and will be truncated silently if they are longer than the string. `omit_na` is a logical argument and will omit the missing values. 


```r
x <- c("gcdi", "digitalfellows")

# subset the 3rd letter
str_sub(x, 3, 3)
```

```
## [1] "d" "g"
```

```r
# subset the 4th to the last character for each element
str_sub(x, 4, -2)
```

```
## [1] ""           "italfellow"
```

```r
# subset the 2nd to the 2nd-to-last character
str_sub(x, 2, -2)
```

```
## [1] "cd"           "igitalfellow"
```

```r
# use str_sub() to modify strings
str_sub(x, 3, 3) <- "MIDDLE"
x
```

```
## [1] "gcMIDDLEi"           "diMIDDLEitalfellows"
```

`str_dup()` is used to duplicate individuals. `string` is the input character vector and `times` specify the number of times to duplicate each string in the character vector. 


```r
x <- c("gcdi", "digitalfellows")
str_dup(x, c(2,3))
```

```
## [1] "gcdigcdi"                                  
## [2] "digitalfellowsdigitalfellowsdigitalfellows"
```

```r
fruit <- c("apple", "pear", "banana")
str_dup(fruit, 2)
```

```
## [1] "appleapple"   "pearpear"     "bananabanana"
```

```r
str_dup(fruit, 1:3)
```

```
## [1] "apple"              "pearpear"           "bananabananabanana"
```
`str_c(.., sep = "", collapse = NULL)` joins two or more vectors element-wise into a single character vector, optionally inserting `sep` between input vectors. `paste()` does the same thing. 


```r
str_c("Letter: ", letters)
```

```
##  [1] "Letter: a" "Letter: b" "Letter: c" "Letter: d" "Letter: e" "Letter: f"
##  [7] "Letter: g" "Letter: h" "Letter: i" "Letter: j" "Letter: k" "Letter: l"
## [13] "Letter: m" "Letter: n" "Letter: o" "Letter: p" "Letter: q" "Letter: r"
## [19] "Letter: s" "Letter: t" "Letter: u" "Letter: v" "Letter: w" "Letter: x"
## [25] "Letter: y" "Letter: z"
```

```r
paste("Letter:" , letters)
```

```
##  [1] "Letter: a" "Letter: b" "Letter: c" "Letter: d" "Letter: e" "Letter: f"
##  [7] "Letter: g" "Letter: h" "Letter: i" "Letter: j" "Letter: k" "Letter: l"
## [13] "Letter: m" "Letter: n" "Letter: o" "Letter: p" "Letter: q" "Letter: r"
## [19] "Letter: s" "Letter: t" "Letter: u" "Letter: v" "Letter: w" "Letter: x"
## [25] "Letter: y" "Letter: z"
```

```r
str_c("Letter", letters, sep = ": ")
```

```
##  [1] "Letter: a" "Letter: b" "Letter: c" "Letter: d" "Letter: e" "Letter: f"
##  [7] "Letter: g" "Letter: h" "Letter: i" "Letter: j" "Letter: k" "Letter: l"
## [13] "Letter: m" "Letter: n" "Letter: o" "Letter: p" "Letter: q" "Letter: r"
## [19] "Letter: s" "Letter: t" "Letter: u" "Letter: v" "Letter: w" "Letter: x"
## [25] "Letter: y" "Letter: z"
```

```r
str_c(letters, collapse = ",")
```

```
## [1] "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z"
```

```r
paste(letters, collapse =",")
```

```
## [1] "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z"
```

### Whitespace

Three functions add, remove, or modify whitespace:

- `str_pad()` pads a string to a fixed length by adding extra whitespace on the left, right, or both sides. You can specify the side with 3 options ("left", "right", "both").You can pad with other characters by using the `pad` argument, but it only takes single padding character (deafult is space)

- `str_trunc(string, width, side = c('right','left','center'), ellipsis = '...')` can truncate a character string. `width` is the maximum width of string. 


```r
(x <- c("abc" , "defghi"))
```

```
## [1] "abc"    "defghi"
```

```r
str_pad(x , 10) # default pads on left
```

```
## [1] "       abc" "    defghi"
```

```r
str_pad(x, 10, "both")
```

```
## [1] "   abc    " "  defghi  "
```

```r
# change padding character 
str_pad(x, 10, pad = "!")
```

```
## [1] "!!!!!!!abc" "!!!!defghi"
```

```r
# *it does a make string shorter
str_pad(x, 4)
```

```
## [1] " abc"   "defghi"
```

```r
# make sure that all strings are the same length 
x %>% str_trunc(6)%>% 
  str_pad(10, "right") 
```

```
## [1] "abc       " "defghi    "
```

```r
x %>% str_trunc(5)%>% 
  str_pad(10, "right")
```

```
## [1] "abc       " "de...     "
```

The opposite of `str_pad()` is `str_trim()`, which removes leading and trailing white space.


```r
x <- c("  a   ", "b   ",  "   c")
str_trim(x)
```

```
## [1] "a" "b" "c"
```

```r
str_trim(x, "left")
```

```
## [1] "a   " "b   " "c"
```

```r
str_trim(x, "right")
```

```
## [1] "  a"  "b"    "   c"
```

`str_wrap` can modify existing whitespace in order to wrap a paragraph of text, such that the length of each line is as similar as possible. It's implementing the Knuth-Plass paragraph wrapping algorithm. 


```r
jabberwocky <- str_c(
  "`Twas brillig, and the slithy toves ",
  "did gyre and gimble in the wabe: ",
  "All mimsy were the borogoves, ",
  "and the mome raths outgrabe. "
)

cat(jabberwocky)
```

```
## `Twas brillig, and the slithy toves did gyre and gimble in the wabe: All mimsy were the borogoves, and the mome raths outgrabe.
```

```r
str_wrap(jabberwocky, width = 40)
```

```
## [1] "`Twas brillig, and the slithy toves did\ngyre and gimble in the wabe: All mimsy\nwere the borogoves, and the mome raths\noutgrabe."
```

### Pattern matching

Pattern matching functions usually have the same first two arguments, a character vector of `string` to process and a single `pattern` to match. **stringr** provides pattern matching functions to detect, locate, extract, match, replace, and split strings. **Regular expression** is useful in extracting information from text such as code, log files, spreadsheets. You can find how to use regular expression [here](https://regexone.com/).

Each pattern matching function has the same first two arguments, a character vetor of `string`s to process and a single `pattern` to match. stringr provides pattern matching functions to detect, locate, extract, match, replace, and split strings. Let's see how to use these functions to work with the strings and a regular expression designed to match (US) phone numbers: 


```r
strings <- c(
  "apple", 
  "219 733 8965", 
  "329-293-8753", 
  "Work: 579-499-7527; Home: 543.355.3679"
)

# define pattern 
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
```

- `str_detect` detects the presence or absence of a pattern and returns a logical vector (similar to `grepl` function in base R).

- `str_subset` returns the elements of a character vector that match a regular expression. (similar to `grep` with `value = T`). 


```r
# Which strings contain phone numbers?
# return matching elements
str_detect(strings, phone)
```

```
## [1] FALSE  TRUE  TRUE  TRUE
```

```r
# negate = TRUE will return non-matching elements
str_detect(strings, phone, negate = TRUE)
```

```
## [1]  TRUE FALSE FALSE FALSE
```

```r
# return character elements instead of logical value
str_subset(strings, phone)
```

```
## [1] "219 733 8965"                          
## [2] "329-293-8753"                          
## [3] "Work: 579-499-7527; Home: 543.355.3679"
```

```r
# return non-matching elements
str_subset(strings, phone, negate = T)
```

```
## [1] "apple"
```

- `string_count` counts number of matches in each string 

- ` str_loate` locates the **first** position of a pattern and returns a numeric matrix with columns start and end. 

- `str_locate_all` locates all matches, returning a list of numeric matrices. Like `regexpr` and `gregexpr`. 


```r
# return vector
str_count(strings, phone)
```

```
## [1] 0 1 1 2
```

```r
# return list
str_locate(strings, phone)
```

```
##      start end
## [1,]    NA  NA
## [2,]     1  12
## [3,]     1  12
## [4,]     7  18
```

```r
# return list
str_locate_all(strings, phone)
```

```
## [[1]]
##      start end
## 
## [[2]]
##      start end
## [1,]     1  12
## 
## [[3]]
##      start end
## [1,]     1  12
## 
## [[4]]
##      start end
## [1,]     7  18
## [2,]    27  38
```

- `str_extract` extracts text corresponding to the first match, returning a character vector. 

- `str_extract_all` extracts all matches and returns a list of character vectors. 


```r
str_extract(strings, phone)
```

```
## [1] NA             "219 733 8965" "329-293-8753" "579-499-7527"
```

```r
str_extract_all(strings, phone)
```

```
## [[1]]
## character(0)
## 
## [[2]]
## [1] "219 733 8965"
## 
## [[3]]
## [1] "329-293-8753"
## 
## [[4]]
## [1] "579-499-7527" "543.355.3679"
```

```r
# simplify = T returns a character matrix instead of a list of character vectors
str_extract_all(strings, phone, simplify = TRUE)
```

```
##      [,1]           [,2]          
## [1,] ""             ""            
## [2,] "219 733 8965" ""            
## [3,] "329-293-8753" ""            
## [4,] "579-499-7527" "543.355.3679"
```

- `string_match` extracts capture groups formed by `()` from the first match and returns a **character matrix** with one column for the complete match and one column for each group in the matched pattern. 

- `str_match_all` extracts capture groups from all matches and returns a list of character matrics. 


```r
str_match(strings, phone)
```

```
##      [,1]           [,2]  [,3]  [,4]  
## [1,] NA             NA    NA    NA    
## [2,] "219 733 8965" "219" "733" "8965"
## [3,] "329-293-8753" "329" "293" "8753"
## [4,] "579-499-7527" "579" "499" "7527"
```

```r
str_match_all(strings, phone)
```

```
## [[1]]
##      [,1] [,2] [,3] [,4]
## 
## [[2]]
##      [,1]           [,2]  [,3]  [,4]  
## [1,] "219 733 8965" "219" "733" "8965"
## 
## [[3]]
##      [,1]           [,2]  [,3]  [,4]  
## [1,] "329-293-8753" "329" "293" "8753"
## 
## [[4]]
##      [,1]           [,2]  [,3]  [,4]  
## [1,] "579-499-7527" "579" "499" "7527"
## [2,] "543.355.3679" "543" "355" "3679"
```

- `str_replace` replaces the first matched patter and returns a character vector. 

- `str_replace_all` replace all matches. Similar to `sub` and `gsub`. 


```r
str_replace(strings, phone, "xxx-xxx-xxxx")
```

```
## [1] "apple"                                 
## [2] "xxx-xxx-xxxx"                          
## [3] "xxx-xxx-xxxx"                          
## [4] "Work: xxx-xxx-xxxx; Home: 543.355.3679"
```

```r
str_replace(strings, phone, "GC-Digital-Fellows")
```

```
## [1] "apple"                                       
## [2] "GC-Digital-Fellows"                          
## [3] "GC-Digital-Fellows"                          
## [4] "Work: GC-Digital-Fellows; Home: 543.355.3679"
```

```r
str_replace_all(strings, phone, "GC-Digital-Fellows")
```

```
## [1] "apple"                                             
## [2] "GC-Digital-Fellows"                                
## [3] "GC-Digital-Fellows"                                
## [4] "Work: GC-Digital-Fellows; Home: GC-Digital-Fellows"
```

- `str_split_fixed` splits a string into a fixed number of pieces based on a pattern and returns a character matrix. Similar to `strsplit` in the base R function. 

- `str_split` splits a string into a **variable** number of pieces and returns a list of character vectors. 


```r
# default of n is Inf 
# uses all possible split positions
str_split('a-b-c', '-')
```

```
## [[1]]
## [1] "a" "b" "c"
```

```r
str_split('a-b-c', '-', n =2)
```

```
## [[1]]
## [1] "a"   "b-c"
```

```r
str_split('a-b-c', '-', n =1)
```

```
## [[1]]
## [1] "a-b-c"
```

```r
# if n is greater than possible number of pieces 
# return still sticks to the maximum number of pieces
str_split('a-b-c', '-', n =4)
```

```
## [[1]]
## [1] "a" "b" "c"
```

```r
# if n is not specified in the function
# error message will show 
str_split_fixed('a-b-c', '-')
```

```
## Error in str_split(string, pattern, n = n, simplify = TRUE): argument "n" is missing, with no default
```

```r
str_split_fixed('a-b-c', '-', n = 2)
```

```
##      [,1] [,2] 
## [1,] "a"  "b-c"
```

```r
str_split_fixed('a-b-c', '-', n = 3)
```

```
##      [,1] [,2] [,3]
## [1,] "a"  "b"  "c"
```

```r
# if n is greater than number of pieces
# result will be padded with empty strings
str_split_fixed('a-b-c', '-', n = 5)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,] "a"  "b"  "c"  ""   ""
```

```r
# when you don't know how many pieces to split
# use str_split
# empty strings is used to show position of the matched pattern
str_split(strings, phone)
```

```
## [[1]]
## [1] "apple"
## 
## [[2]]
## [1] "" ""
## 
## [[3]]
## [1] "" ""
## 
## [[4]]
## [1] "Work: "   "; Home: " ""
```

```r
str_split(strings, '9', simplify = TRUE)
```

```
##      [,1]       [,2]     [,3]     [,4]                       [,5]
## [1,] "apple"    ""       ""       ""                         ""  
## [2,] "21"       " 733 8" "65"     ""                         ""  
## [3,] "32"       "-2"     "3-8753" ""                         ""  
## [4,] "Work: 57" "-4"     ""       "-7527; Home: 543.355.367" ""
```

### Engines 

There are four main engines that stringr can use to describe patterns: 

- Regular expressions, the default, as shown above, and described in `vignette("regular-expressions")`.

- Fixed-sensitive character matching, with `coll()`.

- Text boundary analysis with `boundary()`.

#### Control matching behavior with modifier functions

`fixed(x)`(fixed match) compares literal bytes in the string. This is very fast, but it only matchaes the exact sequence of bytes specified by `x` and not usually what you want for non-ASCII character sets. The restriction can make matching much faster, but it's a little tricky with non-English data. It's problematic because of the multiple ways of representing the same character. For example, defining “á”: either as a single character or as an "a" plus an accent, renders identically. But they're defined differently. 


```r
a1 <- "\u00e1"

a2 <- "a\u0301"

c(a1, a2)
```

```
## [1] "á" "a´"
```

```r
print(a1 == a2)
```

```
## [1] FALSE
```

```r
str_detect(a1, a2)
```

```
## [1] FALSE
```

```r
str_detect(a1, fixed(a2))
```

```
## [1] FALSE
```

`coll`(collation search) compares strings respecting standard collation rules (human character comparison rules). It is especially important if you want to do case insensitive matching. Collation rules differ around the world, so you'll also need to supply a `locale` parameter.

Locale is a fundamental concept in [**ICU**](https://icu.unicode.org/), International Components for Unicode. ICU is implemented as a set of services. If you want to verify whether particular resources are available in the locale you asked for, you must query those resources. Note: when you ask for a resource for a particular locale, you get back the best available match, not necessarily precisely the one you requested. **ICU** services are parametrized by locale, to deliver culturally correct results. Locales are identified by character strings of the form `Language` code, `Language_Country` code, or `Language_Country_Variant` code, e.g., 'en_US'. More details about **locale* can be found [here](https://unicode-org.github.io/icu/userguide/locale/#overview).

`coll` is relatively slow compared to `regex` and `fixed`. Note that when both `fixed` and `regex` have `ignore_case` arguments, they perform a much simpler comparison than `coll`. 


```r
str_detect(a1, coll(a2))
```

```
## [1] TRUE
```

```r
(i <- c("I", "İ", "i", "ı"))
```

```
## [1] "I" "I" "i" "i"
```

```r
str_subset(i, coll("i", ignore_case = TRUE))
```

```
## [1] "I" "I" "i" "i"
```

```r
str_subset(i, coll("i", ignore_case = TRUE, locale = "tr"))
```

```
## [1] "i" "i"
```

```r
str_subset(strings, fixed("w", ignore_case = T))
```

```
## [1] "Work: 579-499-7527; Home: 543.355.3679"
```

```r
str_subset(strings, coll("w", ignore_case = T))
```

```
## [1] "Work: 579-499-7527; Home: 543.355.3679"
```

`boundary` matches boundaries between characters, lines, sentences, or words. It's most useful with `str_split`


```r
x <- "This is a sentence."

str_split(x, boundary("word"))
```

```
## [[1]]
## [1] "This"     "is"       "a"        "sentence"
```

```r
str_count(x, boundary("word"))
```

```
## [1] 4
```

```r
str_extract_all(x, boundary("word"))
```

```
## [[1]]
## [1] "This"     "is"       "a"        "sentence"
```

```r
str_split(x, "")
```

```
## [[1]]
##  [1] "T" "h" "i" "s" " " "i" "s" " " "a" " " "s" "e" "n" "t" "e" "n" "c" "e" "."
```

```r
str_split(x, boundary("character"))
```

```
## [[1]]
##  [1] "T" "h" "i" "s" " " "i" "s" " " "a" " " "s" "e" "n" "t" "e" "n" "c" "e" "."
```

```r
str_count(x, "")
```

```
## [1] 19
```

```r
str_count(x, boundary("character"))
```

```
## [1] 19
```


Reference: 

- The R demo is adapted from the vignettes in `stringr` and written by [Yuxiao Luo](https://github.com/YuxiaoLuo), you can find more details about the original instructions [here](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html).

- The comparison between `stringi` and `stringr` is adapted from [RPubs](https://rpubs.com/Haibiostat/stringi_r) by Hai Nguyen. 


