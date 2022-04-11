# This is the Shiny App_1 script

library(shiny)

# define app UI
ui <- fluidPage(
  titlePanel("Basic widgets"),
  
  # 1st row
  fluidRow(
    
    # edit 1st column in 1st row
    column(width = 3,
           h3("Buttons"),
           actionButton(inputId = "rug", label = "RUG"),
           br(),
           br(),
           submitButton("Submit")),
    
    # edit 1st column in 1st row
    column(width = 3,
           h3("Single checkbox"),
           checkboxInput(inputId = "checkbox", label = "Choice A", value = TRUE)),
    
    # edit 3rd column in 1st row
    column(width = 3,
           checkboxGroupInput("checkGroup",
                              h3("Checkbox group"),
                              choices = list("Choice 1" = 1,
                                             "Choice 2" = 2, 
                                             "Choice 3" = 3),
                              selected = 1)),
    # edit 4th column in 1st row
    column(width = 3,
           dateInput(inputId = "date",
                     h3("Date input"),
                     value = "2022-04-08",
                     startview = "month",
                     weekstart = 1,
                     min = "1900-01-01",
                     max = "2022-12-01"))
  ),
  
  # 2nd row
  fluidRow(
    # edit 1st column in 2nd row
    column(width = 3,
           dateRangeInput(inputId = "dates", 
                          h3("Date range"), 
                          startview = "year",
                          weekstart = "0")),
    # edit 2nd column in 2nd row
    column(width = 3,
           # create a file upload control that can be used to 
           # upload one or more files
           fileInput("file", 
                     label = h3("File input"),
                     # allow multiple upload
                     # only work with new browser 
                     # ex., Explorer 9 and later
                     multiple = TRUE,
                     buttonLabel = "Select the file...",
                     placeholder = "No file selected")),
    
    # edit 3rd column in 2nd row
    column(width = 3,
           h3("Help text"),
           # create help text which can be added to an input form to provide 
           # additional explanation or context
           helpText("Note: help text isn't a true widget, ",
                    "but it provides an easy way to add text to",
                    "accompany other widgets.")),
    
    # edit 4th column in 2nd row
    column(width = 3, 
           # create an input control for entry of numeric values 
           numericInput(inputId = "num", 
                        label = h3("Numeric input"),
                        value = 1,
                        min = 0,
                        max = 100,
                        step = 5,
                        width = '400px'))
    
  ),
  
  # 3rd row
  fluidRow(
    column(3,
           radioButtons(inputId = "radio", 
                        label = h3("Radio buttons"),
                        choices = list(
                          "Choice 1" = 1, 
                          "Choice 2" = 2,
                          "Choice 3" = 3),
                        # initial selected value
                        selected = 1)),
    # 2nd column in 3rd row
    column(3,
           selectInput("select",
                       label = h3("Select box"),
                       choices = list("Choice 1" = 1,
                                      "Choice 2" = 2,
                                      "Choice 3" = 3),
                       selected = 1)),
    
    # 3rd column in 3rd row
    column(3,
           # embed 1st slider
           sliderInput(
                       # input slot being used to access the value
                       inputId = "slider1", 
                       # display label for the control, or NULL for no label
                       label = h3("Slider"),
                       # min value can be selected
                       min = 0, 
                       # max value can be selected
                       max = 100,
                       # initial value of the slider
                       # length one vector create a regular slider
                       value = 50),
           # embed 2nd slider
           sliderInput(inputId = "slider2",
                       label = NULL,
                       min = 0,
                       max = 200,
                       # initial value
                       # length two create a double-ended range slider
                       value = c(25, 75))),
    #4th column in 3rd row
    column(3,
           textInput("text",
                     h3("Text input"),
                     # initial value
                     value = "Enter text here..."))
  )
)

# define server logic 
server <- function(input, output){
  
}

# run the app 
shinyApp(ui = ui, server = server)


