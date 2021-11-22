Yuxiao Luo
11/19/2021

# Introduction to R Markdown

This is a short tutorial to introduce R Markdown for someone who has
experience in R and zero-experience in Markdown, and will discuss the
basic Markdown syntax and essential features in R Markdown. Fore more
details and systematic learning purpose, I recommend you read this book
to know everything about R Markdown: [R Markdown: The Definite
Guide](https://bookdown.org/yihui/rmarkdown/).

## What is Markdown?

Markdown is a simple formatting syntax for authoring HTML, PDF, and MS
Word documents. It is easy to format headings, bold text, italics, etc.
There is a quick reference guide as shown in Figure 1 and links to the
[RStudio cheatsheets](https://www.rstudio.com/resources/cheatsheets/) (a
Markdown cheatsheet is included) can be found in the Help drop-down
menu.

Markdown file (with a suffix `.md`) can be created and written in many
text editors, ex., [Notedpad++](https://notepad-plus-plus.org/), [Visual
Studio Code](https://code.visualstudio.com/), [Windows
Notepad](https://en.wikipedia.org/wiki/Windows_Notepad), and [Terminal
Window](https://en.wikipedia.org/wiki/Windows_Terminal#:~:text=Windows%20Terminal%20is%20a%20command,connect%20to%20Azure%20Cloud%20Shell.).
In short, Markdown files can be seamlessly opened and organized in
almost any editors. In this tutorial, we are going to create and edit a
Markdown file in RStudio.

![figure 1](./images/markdown_cheatsheet.png "Figure 1")*Figure 1*

Let’s walk through the basic Markdown syntax together and try to create
a course Syllabus in Markdown. Here are some of the hints:

-   Emphasis: `*` or `**`
-   Headers: `#`, `##`, and `###`
-   Lists:
    -   Unordered list: `*`, `-`, `+`, etc..
    -   Ordered list: `1`, `2`, etc..
-   Manual Line Breaks: end a line with two or more spaces
-   Links: `[My personal website](https://yuxiaoluo.github.io)`
-   Images: `![alt text](figures/img.png)`
-   Horizontal Rule/Page Break: `******`

## What is R Markdown?

R Markdown provides an authoring framework for data science and can be
used to:

-   save and execute code

-   generate high quality reports that can be shared with an audience

R Markdown documents are fully reproducible and support dozens of static
and dynamic output formats. This [1-minute
video](https://vimeo.com/178485416) should help you better understand
its use.

### How to get started with R Markdown?

R Markdown is free and open source and is integrated in the resourceful
R library, [CRAN](https://cran.r-project.org/). Use the command to
install the `rmarkdown` package in R.

``` r
install.packages("rmarkdown")
library(rmarkdown)
```

Then, you can navigate to the Menu bar and open a new R markdown file
following `File` –&gt; `New File` –&gt; `R Markdown...`.

### Output the R Markdown file

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. R Markdown generates a new file that
contains selected text, code, and results from the `.Rmd` file. The new
file can be a finished web page, PDF, MS Word document, slide show,
notebook, handout, book, dashboard, package vignette or other format.
When you run `render`, R Markdown feeds the `.Rmd` file to `knitr`,
which executes all of the code chunks and creates a new markdown (.md)
document which includes the code and its output. R Markdown can be
rendered to different formats and to more than one type of documents a
the same time by specifying one or more formats in the output argument.

#### Output formats

You can either use the RStudio IDE `Knit` button on the top bar of the
`.Rmd` script window to render your `.Rmd` file to other format, or
write the`render` function in the RStudio console to do the same thing.

Set the `output_format` argument of `render` to render your `.Rmd` file
into any of R Markdown’s supported formats. For example, the code below
renders 1-example.Rmd to a Microsoft Word document.

``` r
library(rmarkdown)
render("1-example.Rmd", output_format = "word_document")
```

If you do not select a format, R Markdown renders the file to its
default format, which you can set in the output field of a `.Rmd` file’s
header. The header of a raw R Markdown script shows that it renders to
an HTML file by default. The list below shows the variable formats to
output with R Markdown.

-   html\_notebook - Interactive R Notebooks

-   html\_document - HTML document w/ Bootstrap CSS

-   pdf\_document - PDF document (via LaTeX template)

-   word\_document - Microsoft Word document (docx)

-   odt\_document - OpenDocument Text document

-   rtf\_document - Rich Text Format document

-   md\_document - Markdown document (various flavor

Please also be aware of that this short list doesn’t include all the
possible formats and you have other options, ex., github\_document,
which s GitHub Flavored Markdown document. You can also build books,
websites, and interactive documents with R Markdown. For more details,
you can check out the [this
lesson](https://rmarkdown.rstudio.com/lesson-9.html).

### R Code Chunks

In R Markdown, you edit the R code in a code chunk. `Ctrl+Alt+i` is the
shortcut for creating R code chunk. You can also create code chunks
executing other programming languages like Python, Bash, SQL, etc.

#### Embeding R code

You can embed an R code chunk like this:

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

It’s important to remember when you are creating an RMarkdown file that
if you want to run code that refers to an object, for example:

``` r
print(dataframe)
```

you should include instructions showing what is the `dataframe`, just
like a normal step in R script. For example:

``` r
A <- c("a", "a", "b", "b")
B <- c(5, 9, 85, 23)
dataframe <- data.frame(A, B)
print(dataframe)
```

    ##   A  B
    ## 1 a  5
    ## 2 a  9
    ## 3 b 85
    ## 4 b 23

If you are loading a dataframe from a `.csv` file, you must include the
code in the `.Rmd`

``` r
dataframe <- read.csv("~/Desktop/Code/dataframe.csv")
```

#### Including plots

You can also embed plots, for example:

![](Intro_RMarkdown_files/figure-gfm/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.

#### Inserting figures

Inserting a graph into RMarkdown is easy, the more energy-demanding
aspect might be adjusting the formatting.

By default, RMarkdown will place graphs by maximizing their height,
while keeping them within the margins of the page and maintaining aspect
ratio. If you have a particularly tall figure, this can mean a really
huge graph. In the following example we modify the dimensions of the
figure we created above. To manually set the figure dimensions, you can
insert an instruction into the curly braces:

``` r
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)
```

    ##   A  B
    ## 1 a  5
    ## 2 a 10
    ## 3 b 15
    ## 4 b 20

``` r
boxplot(B~A,data=dataframe)
```

![](Intro_RMarkdown_files/figure-gfm/insert%20figure-1.png)<!-- -->

#### Inserting tables

While R Markdown can print the contents of a dataframe easily by
enclosing the name of the data frame in code chunk.

Another pleasing way for simple table formatting is `kable()` in the
`knitr` package. The first argument tells kable to make a table out of
the object `dataframe` and that numbers hould have to significant
figures.

``` r
library(knitr)
```

    ## Warning: package 'knitr' was built under R version 4.0.3

``` r
kable(dataframe, digits = 2)
```

| A   |   B |
|:----|----:|
| a   |   5 |
| a   |  10 |
| b   |  15 |
| b   |  20 |

If you want to control the content in your table, you can use `pander()`
in the package `pander`. Remember to load the package in code chunk as
well. The code below I want the 3rd column to appear in italics:

``` r
library(pander)
plant <- c("a", "b", "c")
temperature <- c(20, 20, 20)
growth <- c(0.65, 0.95, 0.15)
dataframe <- data.frame(plant, temperature, growth)
emphasize.italics.cols(3)   # Make the 3rd column italics
pander(dataframe)           # Create the table
```

| plant | temperature | growth |
|:-----:|:-----------:|:------:|
|   a   |     20      | *0.65* |
|   b   |     20      | *0.95* |
|   c   |     20      | *0.15* |

Alternatively, you may also create tables using Markdown syntax.

#### Creating tables from model outputs

Using `tidy()` from the package `broom`, we are able to create tables of
our model outputs, and insert these tables into our markdown file. The
example below shows a simple example linear model, where the summary
output table can be saved as a new R object and then added into the
markdown file.

``` r
library(broom)
library(pander)
A <- c(20, 15, 10)
B <- c(1, 2, 3)

lm_test <- lm(A ~ B)          # Creating linear model

table_obj <- tidy(lm_test)    # Using tidy() to create a new R object called table

pander(table_obj, digits = 3) # Using pander() to view the created table, with 3 sig figs 
```

|    term     | estimate | std.error | statistic | p.value  |
|:-----------:|:--------:|:---------:|:---------:|:--------:|
| (Intercept) |    25    | 4.07e-15  | 6.14e+15  | 1.04e-16 |
|      B      |    -5    | 1.88e-15  | -2.65e+15 | 2.4e-16  |

#### Chunk options

R Markdown is using `knitr` to generate the `.md` file. There are more
than 50 chunk options that can be used to fine-tune the behavior of
*knitr* when processing R chunks. Please refer to the online
documentation [here](https://yihui.org/knitr/options/) for the full list
of options.

You can apply the chunk options to individual code chunks; You can also
apply any chunk options globally to a whole document, so you don’t have
to repeat the options in every single code chunk. To set chunk options
globally, call `knitr::opts_chunk$set()` in a code chunk (usually the
first one in the document), like the first code chunk in this R Markdown
document.

``` r
knitr::opts_chunk$set(
  comment = "#>", echo = FALSE, fig.width = 6
)
```

-   `eval`: (`TRUE`; logical or numeric) Whether to evaluate the code
    chunk. It can also be a numeric vector to choose which R
    expression(s) to evaluate, e.g., `eval = c(1, 3, 4)` will evaluate
    the first, third, and fourth expressions, and `eval = -(4:5)` will
    evaluate all expressions except the fourth and fifth.

-   `echo`: (`TRUE`; logical or numeric) Whether to display the source
    code in the output document. Besides TRUE/FALSE, which shows/hides
    the source code, we can also use a numeric vector to choose which R
    expression(s) to echo in a chunk, e.g., echo = 2:3 means to echo
    only the 2nd and 3rd expressions, and echo = -4 means to exclude the
    4th expression.

-   `warning`: (`TRUE`; logical) Whether to preserve warnings (produced
    by warning()) in the output. If FALSE, all warnings will be printed
    in the console instead of the output document. It can also take
    numeric values as indices to select a subset of warnings to include
    in the output. Note that these values reference the indices of the
    warnings themselves (e.g., 3 means “the third warning thrown from
    this chunk”) and not the indices of which expressions are allowed to
    emit warnings.

-   `include`: (`TRUE`; logical) Whether to include the chunk output in
    the output document. If FALSE, nothing will be written into the
    output document, but the code is still evaluated and plot files are
    generated if there are any plots in the chunk, so you can manually
    insert figures later.

## Reference:

-   [R for Health Data
    Science](https://argoshare.is.ed.ac.uk/healthyr_book/) by Ewen
    Harrison and Riinu Pius

-   [R Markdown Lesson](https://rmarkdown.rstudio.com/lesson-1.html)
    from RStudio

-   [Getting started with R
    Markdown](https://ourcodingclub.github.io/tutorials/rmarkdown/) by
    John

-   [R Markdown: The Definite
    Guide](https://bookdown.org/yihui/rmarkdown/) by Yihui Xie, J. J.
    Allaire, and Garrett Grolemund
