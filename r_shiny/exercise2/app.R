
# this is the script file for the shiny app: exercise2

library(shiny)

# define ui
ui <- fluidPage(
  
  titlePanel("RUG Meeting Demo"),
  
  sidebarLayout(
    sidebarPanel(
      
      # help text for the input control widget
      helpText("Question: do you like the RUG meeting topis so far?"),
      
      selectInput(inputId = "var",
                  label = "How much do you like the Shiny topic in RUG meeting?",
                  choices = list("Strongly like it",
                                 "Somewhat like it",
                                 "Neither like it nor dislike it",
                                 "Somewhat dislike it",
                                 "Strongly dislike it"),
                  selected = "Somewhat like it"),
      
      # insert slider widget
      sliderInput(inputId = "range",
                  label = "Range of interest: ",
                  min = 0,
                  max = 100, 
                  value = c(0,100))
    ),
    mainPanel()
  )
)

# define server logic
server <- function(input, output){
  
}  

# run app
shinyApp(ui = ui, server = server)































