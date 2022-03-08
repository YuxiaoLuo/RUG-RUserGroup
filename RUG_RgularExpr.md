RUG1022\_Regex
================
Yuxiao Luo
10/21/2021

# Intro to Regular Expressions in R

Regular expressions can describe patterns in strings. This is short demo
cannot include all the details about regular expressions, if you are
interested, please find more [here](https://r4ds.had.co.nz/strings.html)
or explore in [RegexOne](https://regexone.com/) and [Regular Expression
Info](https://www.regular-expressions.info/index.html).

## Basic match

Regular expressions are the default pattern engine in `stringr`. When
you use a pattern matching function with a bare string, it’s euivalent
to wrapping it in a call to `regex()`. You will need to use `regex()`
explicitly if you want to override the default options by changing the
arguments in `regex()`.

``` r
library(stringr)
```

`fruit` and `words` are vectors of words come from the `rcorpora`
package written by Gabor Csardi. Let’s do some basic matches using
`str_extract` and `str_detect`.

``` r
fruit
```

    ##  [1] "apple"             "apricot"           "avocado"          
    ##  [4] "banana"            "bell pepper"       "bilberry"         
    ##  [7] "blackberry"        "blackcurrant"      "blood orange"     
    ## [10] "blueberry"         "boysenberry"       "breadfruit"       
    ## [13] "canary melon"      "cantaloupe"        "cherimoya"        
    ## [16] "cherry"            "chili pepper"      "clementine"       
    ## [19] "cloudberry"        "coconut"           "cranberry"        
    ## [22] "cucumber"          "currant"           "damson"           
    ## [25] "date"              "dragonfruit"       "durian"           
    ## [28] "eggplant"          "elderberry"        "feijoa"           
    ## [31] "fig"               "goji berry"        "gooseberry"       
    ## [34] "grape"             "grapefruit"        "guava"            
    ## [37] "honeydew"          "huckleberry"       "jackfruit"        
    ## [40] "jambul"            "jujube"            "kiwi fruit"       
    ## [43] "kumquat"           "lemon"             "lime"             
    ## [46] "loquat"            "lychee"            "mandarine"        
    ## [49] "mango"             "mulberry"          "nectarine"        
    ## [52] "nut"               "olive"             "orange"           
    ## [55] "pamelo"            "papaya"            "passionfruit"     
    ## [58] "peach"             "pear"              "persimmon"        
    ## [61] "physalis"          "pineapple"         "plum"             
    ## [64] "pomegranate"       "pomelo"            "purple mangosteen"
    ## [67] "quince"            "raisin"            "rambutan"         
    ## [70] "raspberry"         "redcurrant"        "rock melon"       
    ## [73] "salal berry"       "satsuma"           "star fruit"       
    ## [76] "strawberry"        "tamarillo"         "tangerine"        
    ## [79] "ugli fruit"        "watermelon"

``` r
# The regular call
str_extract(fruit, "nana")
```

    ##  [1] NA     NA     NA     "nana" NA     NA     NA     NA     NA     NA    
    ## [11] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [21] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [31] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [41] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [51] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [61] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [71] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA

``` r
# is the shorthand for 
str_extract(fruit, regex("nana"))
```

    ##  [1] NA     NA     NA     "nana" NA     NA     NA     NA     NA     NA    
    ## [11] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [21] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [31] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [41] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [51] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [61] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA    
    ## [71] NA     NA     NA     NA     NA     NA     NA     NA     NA     NA

``` r
(x <- fruit[1:3])
```

    ## [1] "apple"   "apricot" "avocado"

``` r
str_extract(x, "ap")
```

    ## [1] "ap" "ap" NA

``` r
# You can perform a case-insensitive match using
# ignore_case = T in regex()
bananas <- c("banana", "Banana", "BANANA")

str_detect(bananas, "banana")
```

    ## [1]  TRUE FALSE FALSE

``` r
str_detect(bananas, regex("banana", ignore_case = T))
```

    ## [1] TRUE TRUE TRUE

``` r
# . can match any character except a newline
str_extract(x, ".a.")
```

    ## [1] NA    NA    "cad"

``` r
str_detect("\nX\n", ".X.")
```

    ## [1] FALSE

``` r
# But you can allow . to match everything, including \n
# setting dotall = TRUE
str_detect("\nX\n", regex(".X.", dotall = T))
```

    ## [1] TRUE

## Escaping

You need to use an “escape” when you want to match a literal “.”.

-   Like strings, regexps use the backslash ,`\`, to escape special
    behavior.

-   To match a `.`, you need the regexp `\.`. We use strings to
    represent regular expressions, and `\` is also used as an escape
    symbol in strings.

-   So to create the regular expression `\.`, we need the string `"\\."`
    because both strings and regular expressions are using `\` as escape
    symbol. In other words, We use `\.` to denote the regular
    expression, and use `"\\."` to denote the string that represents a
    regular expression.

``` r
# create the regex for dot
dot <- "\\."
dot
```

    ## [1] "\\."

``` r
writeLines(dot)
```

    ## \.

``` r
# And this tells R to look for an explicit dot
str_extract(c("abc", "a.c", "bef"), "a\\.c")
```

    ## [1] NA    "a.c" NA

``` r
str_detect(c("abc", "a.c"), "a\\.c")
```

    ## [1] FALSE  TRUE

An alternative quoting mechanism is `\Q...\E`: all the characters in
`...` are treated as exact matches. This is useful if you want to
exactly match user input as part of a regular expression.

``` r
x <- c("a.b.c.d", "aeb")
starts_with <- "a.b"

# dot can represent anything except newline
str_extract(x , paste0("^", starts_with))
```

    ## [1] "a.b" "aeb"

``` r
# dot can only represent dot with `\Q...\W`
str_extract(x ,paste0("^\\Q", starts_with, "\\E"))
```

    ## [1] "a.b" NA

## Special characters

Escapes also allow you to specify individual characters that are
otherwise hard to type. You can specify individual unicode characters in
five ways, either as a variable number of hex digits (four is most
common), or by name:

-   `\xhh`: 2 hex digits.
-   `\x{hhhh}`: 1-6 hex digits.
-   `\uhhhh`: 4 hex digits.
-   `\Uhhhhhhhh`: 8 hex digits.
-   `\N{name}`, e.g. `\N{grinning face}` matches the basic smiling
    emoji.

### Hexadecimal

Note that Hexadecimal (or **hex**) is a base 16 system used to simplify
how binary is represented. A hex digit can be any of the following 16
digits: 0 1 2 3 4 5 6 7 8 9 A B C D E F. Each hex digit reflects a
4-**bit** binary sequence. Hex codes are used in many areas of computing
to simplify binary codes. Computers do not use hexadecimal and it is
only used by humans to shorten binary to a more easily understandable
form. Hexadecimal can be used for color references (ex., white is
**\#FFFFFF** and `#` symbol indicates that number has been written in
hex format), assembly language programs, and error messages. If you are
making a web page with HTML or CSS, you can use hex codes to choose the
colors.

The table below shows the conversion among Denary, Binary, and
Hexadecimal number system.

| Denary | Binary | Hexadecimal |
|:------:|:------:|:-----------:|
|   0    |  0000  |      0      |
|   1    |  0001  |      1      |
|   2    |  0010  |      2      |
|   3    |  0011  |      3      |
|   4    |  0100  |      4      |
|   5    |  0101  |      5      |
|   6    |  0110  |      6      |
|   7    |  0111  |      7      |
|   8    |  1000  |      8      |
|   9    |  1001  |      9      |
|   10   |  1010  |      A      |
|   11   |  1011  |      B      |
|   12   |  1100  |      C      |
|   13   |  1101  |      D      |
|   14   |  1110  |      E      |
|   15   |  1111  |      F      |

For example:

-   **11010100** in binary would be **D4** in hex
-   **FFFF3** in hex is **11111111111111110011** in binary

### Control Characters

Similarly, you can specify many common control characters:

-   `\a`: bell.
-   `\cX`: match a control-X character.
-   `\e`: escape (`\u001B`).
-   `\f`: form feed (`\u000C`).
-   `\n`: line feed (`\u000A`).
-   `\r`: carriage return (`\u000D`).
-   `\t`: horizontal tabulation (`\u0009`).
-   `\0ooo` match an octal character. ‘ooo’ is from one to three octal
    digits, from 000 to 0377. The leading zero is required.

``` r
y <- c("1233", "123")
str_extract(y, ".")
```

    ## [1] "1" "1"

## Matching multiple characters

There are a number of patterns that match more than one character.
You’ve already seen `.`, which matches any character (except a newline).
**A closely related operator is `\X`, which matches a grapheme cluster,
a set of individual elements that form a single symbol**. For example,
one way of representing “á” is as the letter “a” plus an accent: `.`
will match the component “a”, while `\X` will match the complete symbol:

``` r
x <- "a\u0301"
str_extract(x, ".")
```

    ## [1] "a"

``` r
str_extract(x, "\\X")
```

    ## [1] "a´"

There are five other escaped pairs that match narrower classes of
characters:

-   `\d` matches any digit. The complement, `\D` matches any character
    that is not a decimal digit.

``` r
str_extract_all("1 + 2 = 3", "\\d+")[[1]]
```

    ## [1] "1" "2" "3"

``` r
#> [1] "1" "2" "3"
```

Technically, `\d` includes any character in the Unicode Category of Nd
(“Number, Decimal Digit”), which also includes numeric symbols from
other languages:

``` r
# Some Laotian numbers
str_detect("១២៣", "\\d")
```

    ## [1] TRUE

``` r
#> [1] TRUE
```

-   `\s` matches any whitespace. This includes tabs, newlines, form
    feeds, and any character in the Unicode Z Category (which includes a
    variety of space characters and other separators.). The complement,
    `\S`, matches any non-whitespace character.

``` r
(text <- "Some  \t badly\n\t\tspaced \f text")
```

    ## [1] "Some  \t badly\n\t\tspaced \f text"

``` r
str_replace_all(text, "\\s+", " ")
```

    ## [1] "Some badly spaced text"

-   `\p{property name}` matches any character with specific unicode
    property, like `\p{Uppercase}` or `\p{diacritic}`. The complement,
    `\P{property name}`, matches all characters without the property. A
    complete list of unicode properties can be found
    [here](http://www.unicode.org/reports/tr44/#Property_Index). Note:
    The properties can be used to handle characters (code points) in
    processes, like in line-breaking, script direction right-to-left or
    applying controls. Some “character properties” are also defined for
    code points that have no character assigned, and code points that
    are labeled like “<not a character>”. The character properties are
    described in [Standard Annex
    \#44](https://www.unicode.org/reports/tr44/). Properties have levels
    of forcefulness: normative, informative, contributory, or
    provisional.

``` r
(text <- c('"Double quotes"', "«Guillemet»", "“Fancy quotes”"))
```

    ## [1] "\"Double quotes\"" "«Guillemet»"       "“Fancy quotes”"

``` r
str_replace_all(text, "\\p{quotation mark}", "'")
```

    ## [1] "'Double quotes'" "'Guillemet'"     "'Fancy quotes'"

-   `\w` matches any “word” character, which includes alphabetic
    characters, marks and decimal numbers. The complement, `\W`, matches
    any non-word character. Technically, `\w` also matches [connector
    punctuation](http://www.unicode.org/charts/beta/script/chart_Punctuation-Connector.html),
    `\u200c` (zero width connector), and `\u200d` (zero width joiner),
    but these are rarely seen in the wild.

``` r
str_extract_all("Don't eat that!", "\\w+")[[1]]
```

    ## [1] "Don"  "t"    "eat"  "that"

``` r
str_split("Don't eat that!", "\\W")[[1]]
```

    ## [1] "Don"  "t"    "eat"  "that" ""

-   `\b` matches word boundaries, the transition between word and
    non-word characters. `\B` matches the opposite: boundaries that have
    either both word or non-word characters on either side.

``` r
str_replace_all("The quick brown fox", "\\b", "_")
```

    ## [1] "_The_ _quick_ _brown_ _fox_"

``` r
str_replace_all("The quick brown fox", "\\B", "_")
```

    ## [1] "T_h_e q_u_i_c_k b_r_o_w_n f_o_x"

You can also create your own character classes using `[]`:

-   `[abc]`: matches a, b, or c.
-   `[a-z]`: matches every character between a and z (in Unicode code
    point order).
-   `[^abc]`: matches anything except a, b, or c.
-   `[\^\-]`: matches ^ or -.

There are a number of pre-built classes that you can use inside `[]`:

-   `[:punct:]`: punctuation.
-   `[:alpha:]`: letters.
-   `[:lower:]`: lowercase letters.
-   `[:upper:]`: upperclass letters.
-   `[:digit:]`: digits.
-   `[:xdigit:]`: hex digits.
-   `[:alnum:]`: letters and numbers.
-   `[:cntrl:]`: control characters.
-   `[:graph:]`: letters, numbers, and punctuation.
-   `[:print:]`: letters, numbers, punctuation, and whitespace.
-   `[:space:]`: space characters (basically equivalent to ).
-   `[:blank:]`: space and tab.

These all go inside the `[]` for character classes, i.e. `[[:digit:]AX]`
matches all digits, A, and X.

You can also using Unicode properties, like `[\p{Letter}]`, and various
set operations, like `[\p{Letter}--\p{script=latin}]`. See
`?"stringi-search-charclass"` for details.

A cheat-sheet of Regex is attached below
([source](http://stanford.edu/~wpmarble/webscraping_tutorial/regex_cheatsheet.pdf)):

## Alternation

`|` is the alternation operator and it picks between one or more
possible matche, acting as the `or` logic expression.

``` r
str_detect(c("abc","def","ghi"), "abc|def")
```

    ## [1]  TRUE  TRUE FALSE

## Grouping

You can use parenthese to override the default precedence rules.

``` r
str_extract(c("grey", "gray"), "gre|ay")
```

    ## [1] "gre" "ay"

``` r
str_extract(c("grey", "gray"), "gr(e|a)y")
```

    ## [1] "grey" "gray"

Parenthesis also define “groups” that you can refer to with
backreferences, like `\1`, `\2` etc, and can be extracted with
`str_match()`. For example, the following regular expression finds all
fruits that have a repeated pair of letters:

``` r
pattern <- "(..)\\1"

fruit %>% 
  str_subset(pattern)
```

    ## [1] "banana"      "coconut"     "cucumber"    "jujube"      "papaya"     
    ## [6] "salal berry"

``` r
fruit %>% 
  str_subset(pattern) %>% 
  str_match(pattern)
```

    ##      [,1]   [,2]
    ## [1,] "anan" "an"
    ## [2,] "coco" "co"
    ## [3,] "cucu" "cu"
    ## [4,] "juju" "ju"
    ## [5,] "papa" "pa"
    ## [6,] "alal" "al"

You can use `(?:...)`, the non-grouping parentheses, to control
precedence but not capture the match in a group. This is slightly more
efficient than capturing parentheses.

``` r
str_match(c("grey", "gray"), "gr(e|a)y")
```

    ##      [,1]   [,2]
    ## [1,] "grey" "e" 
    ## [2,] "gray" "a"

``` r
str_match(c("grey", "gray"), "gr(?:e|a)y")
```

    ##      [,1]  
    ## [1,] "grey"
    ## [2,] "gray"

This is most useful for more complex cases where you need to capture
matches and control precedence independently.

## Anchors

By default, regular expressions will match any part of a string. It’s
often useful to anchor the regular expression so that it matches from
the start or end of the string:

-   `^` matches the start of string.
-   `$` matches the end of the string.

![Regular Expression Cheat Sheet](./images/regex_cheatsheet.pdf)

Reference:

-   The R demo is adapted from the vignettes in `stringr` and written by
    [Yuxiao Luo](https://github.com/YuxiaoLuo), you can find more
    details about the original instructions
    [here](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html).

-   The introduction about Hexadecimals is adapted from this
    [guide](https://www.bbc.co.uk/bitesize/guides/zp73wmn/revision/2).
