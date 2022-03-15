#########################
# Build a user interface

# how to lay out the user interface and then add text, images, and other HTML
# elements to Shiny app

# Let's add more elements in the fluidPage function
ui <- fluidPage(
  titlePanel("My Star Wars Apps"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h6("Episode IV", align = "center"),
      h6("A NEW HOPE", align = "center"),
      h5("It is a period of civil war.", align = "center"),
      h4("Rebel spaceships, striking", align = "center"),
      h3("from a hidden base, have won", align = "center"),
      h2("their first victory against the", align = "center"),
      h1("evil Galactic Empire."),
      img(src = "avator.png", height = 120, width = 120)
    )
  )
)

# define server logic --- 
server <- function(input, output){
  
}

# run the app --- 
shinyApp(ui = ui, server = server)




