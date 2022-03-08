## Adding UI controls
ui <- fluidPage(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
  verbatimTextOutput("summary"), 
  tableOutput("table")
)

# fluidPage() is a layout function that sets up the basic visual structure of 
# the page 

# selectInput() is an input control that lets the user interact with the app by providing
# a value. 

# verbatimTextOutput() and tableOutput() are output controls that tell Shiny where
# to put rendered output (we'll get into the how in a moment)

# verbatimTextOutput() displays code and tableOutput() displays tables. 


# layout functions, inputs, and outputs have different uses, but they are fundamentally 
# the same under the covers: they’re all just fancy ways to generate HTML, and 
# if you call any of them outside of a Shiny app, 
# you’ll see HTML printed out at the console.

server <- function(input, output, session){
  output$summary <- renderPrint({
    dataset <- get(input$dataset, "package:datasets")
    summary(dataset)
  })
  output$table <- renderTable({
    dataset <- get(input$dataset, "package:datasets")
    dataset
  })
}

# renderPrint() prints the result of exprm, equivalent to print()

# renderPrint() is paired with verbatimTextOutput() to display a statistical 
# summary with fixed-width (verbatim) text

# renderTable() is paired with tableOutput() to show the input data in a table.

shinyApp(ui, server)






















