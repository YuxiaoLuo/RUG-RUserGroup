Introduction to Shiny
================
Yuxiao Luo
03/11/2022

## Shiny apps

Shiny apps are contained in a single script called `app.R`. `app.R` has
3 components:

-   a user interface object
-   a server function
-   a call to the `shinyApp` function, `shinyApp(ui, server)`

The script `app.R` lives in a directory (for example, `newdir/`) and the
app can be run with `runApp("newdir")`.

Let’s see what Shiny apps we have in the directory.

``` r
library(shiny)
list.files()
```

    ## [1] "app_2"             "avator.png"        "Hello_World"      
    ## [4] "intro_shiny.md"    "intro_shiny.Rmd"   "intro_shiny_files"
    ## [7] "main.R"            "r_shiny.Rproj"     "user_interface"

To run the app of `Hello_World`.

``` r
runApp('Hello_World')
```

There are other code examples in Shiny.

``` r
# Some examples in Shiny
runExample("01_hello")      # a histogram
runExample("02_text")       # tables and data frames
runExample("03_reactivity") # a reactive expression
runExample("04_mpg")        # global variables
runExample("05_sliders")    # slider bars
runExample("06_tabsets")    # tabbed panels
runExample("07_widgets")    # help text and submit buttons
runExample("08_html")       # Shiny app built from HTML
runExample("09_upload")     # file upload wizard
runExample("10_download")   # file download wizard
runExample("11_timer")      # an automated timer
```

A framework of the Shiny app.

``` r
# define UI ---
ui <- fluidPage(
  
)

# define server logic --- 
server <- function(input, output){
  
}

# run the app --- 
shinyApp(ui = ui, server = server)

# result: blank user interface
```

The result of the code is a blank user interface.

## Let’s add some elements

### `sidebarLayout` for layout design

These functions place content in either the sidebar or the main panels.

`sidebarLayout` has two arguments:

-   `sidebarPanel` function output
-   `mainPanel` function output

You can move the sidebar panel to the right side by giving
`sidebarLayout` the optional argument: `position = "right"`

`titlePanel` and `sidebarLayout` create basic layout. `navbarPage` can
provide a multi-page user interface that includes a navigation bar. You
can also use `fluidRow` and `column` to build layout from a grid system.
Those advanced options can be found in the [Shiny Application Layout
Guide](https://shiny.rstudio.com/articles/layout-guide.html).

### HTML content

We can use HTML tag functions in Shiny, which are parallel common HTML5
tags.

**shiny function HTML5 equivalent creates**

|        |            |                                                  |
|:------:|:----------:|:------------------------------------------------:|
|   p    |   `<p>`    |               A paragraph of text                |
|   h1   |   `<h1>`   |               A first level header               |
|   h2   |   `<h2>`   |              A second level header               |
|   h3   |   `<h3>`   |               A third level header               |
|   h4   |   `<h4>`   |              A fourth level header               |
|   h5   |   `<h5>`   |               A fifth level header               |
|   h6   |   `<h6>`   |               A sixth level header               |
|   a    |   `<a>`    |                   A hyper link                   |
|   br   |   `<br>`   |         A line break (e.g. a blank line)         |
|  div   |  `<div>`   |     A division of text with a uniform style      |
|  span  |  `<span>`  | An in-line division of text with a uniform style |
|  pre   |  `<pre>`   |        Text ‘as is’ in a fixed width font        |
|  code  |  `<code>`  |            A formatted block of code             |
|  img   |  `<img>`   |                     An image                     |
| strong | `<strong>` |                    Bold text                     |
|   em   |   `<em>`   |                 Italicized text                  |
|  HTML  |            | Directly passes a character string as HTML code  |

#### Headers

We first create a header element and then pass it as an argument to
`titlePanel`, `sidePanel`, or `mainPanel`.

``` r
h1("My first header")
```

<h1>My first header</h1>

``` r
# <h1>My title</h1>
```

Let’s try to use six levels of headers. Then, we can update ui.R to
match the script and then relaunch the app `runApp('user_interface)`.

``` r
ui <- fluidPage(
  titlePanel('My first shiny app'),
  
  sidebarLayout(
    position = 'right'
    sidebarPanel('Sidebar Panel'),
    mainPanel(
      h1("First level title"),
      h2("Second level title"),
      h3("Third level title"),
      h4("Fourth level title"),
      h5("Fifth level title"),
      h6("Sixth level title")
    )
  )
)

# run the udpated app
runApp('user_interface')
```

In general, any HTML tag attribute can be set as an argument in any
Shiny tag function. We can find the HTML tag attributes in many free
online HTML resources such as
[w3schools](https://www.w3schools.com/tags/tag_hn.asp).

For example, we can update the user interface and make it a Star
Was-inspired user interface:

``` r
ui <- fluidPage(
  titlePanel("My Star Wars App"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h6("Episode IV", align = "center"),
      h6("A NEW HOPE", align = "center"),
      h5("It is a period of civil war.", align = "center"),
      h4("Rebel spaceships, striking", align = "center"),
      h3("from a hidden base, have won", align = "center"),
      h2("their first victory against the", align = "center"),
      h1("evil Galactic Empire.")
    )
  )
)
```

#### Formatted text

Shiny offers many tag functions for formatting text, same as the HTML
tags.

#### Images

Shiny looks for the `img` function to place image files in your app. To
insert an image, give the `img` function the name of your image file as
the `src` argument (e.g., `img(src = "my_image.png"))`. You must spell
out this argument since `img` passes your input to an HTML tag, and
`src` is what the tag expects. Please always put the picture in the
folder named `www`, which should be placed in the same directory of that
Shiny app.

You can also include other HTML friendly parameters such as height and
width. Note that height and width numbers will refer to pixels.

``` r
img(src = "my_image.png", height = 72, width = 72)
```
