# Your first shiny app

library(shiny)

# define user interface
ui <- fluidPage(
  "Hello, world!"
)

# define server
server <- function(input, output, session) {
}

# run shiny ap
shinyApp(ui, server)

# Listening on http://127.0.0.1:4103
# This tells you URL where you app can be found: 127.0.0.1 is a standard address
# that means "this computer" and 3827 is a randomly assigned port number 

# You can enter that URL into any compatiblae web browser to open another copy
# of the app 











