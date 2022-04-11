#########################
# main script

# Shiny apps are contained in a single script called app.R
# app.R has 3 components: 
# 1. a user interface object
# 2. a server function
# 3. a call to the shinyApp function, shinyApp(ui, server)

# The script app.R lives in a directory (for example, newdir/) and 
# the app can be run with runApp("newdir").

# to run the app of Hello World
library(shiny)

# run a shiny app, the folder name/directory where 
# the app locates in 
runApp('Hello_World')
runApp('app_2')

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

##############################################
# a framework of shiny app

library(shiny)

# define UI ---
ui <- fluidPage(
  
)

# define server logic --- 
server <- function(input, output){
  
}

# run the app --- 
shinyApp(ui = ui, server = server)

# result: blank user interface


# 1. add titlePanel, sidebarLayout

# sidebarLayout has two arguments:
#   1. sidebarPanel 
#   2. mainPanel

runApp('widgePractice')

