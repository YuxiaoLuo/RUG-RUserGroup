#########################
# Build a user interface

# how to lay out the user interface and then add text, images, and other HTML
# elements to Shiny app

# Let's add more elements in the fluidPage function
# This ui function outputs the Starwar interface
# ui <- fluidPage(
#   titlePanel("My Star Wars Apps"),
#   sidebarLayout(
#     sidebarPanel(),
#     mainPanel(
#       h6("Episode IV", align = "center"),
#       h6("A NEW HOPE", align = "center"),
#       h5("It is a period of civil war.", align = "center"),
#       h4("Rebel spaceships, striking", align = "center"),
#       h3("from a hidden base, have won", align = "center"),
#       h2("their first victory against the", align = "center"),
#       h1("evil Galactic Empire."),
#       img(src = "avator.png", height = 400, width = 400)
#     )
#   )
# )

ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(
      strong("This is the sidebar Panel"),
      p("Main panel shows the instruction on formatted text.")
      
    ),
    mainPanel(
      p("p creates a paragraph of text."),
      p("A new p() command starts a new paragraph. Supply a style 
      attribute to change the format of the entire paragraph.", 
        style = "font-family: 'times'; font-sil16pt"),
      strong("strong() makes bold text."), 
      em("em() creates italicized (i.e, emphasized) text."), 
      br(),
      code("code displays your text similar to computer code"),
      div("div creates segments of text with a similar style. This division
          of text is all blue because I passed the argument 
          'style = color:blue' to div", style = "color:blue"),
      br(),
      p("span does the same thing as div, but it works with",
        span("groups of words", style = "color:blue"),
        "that appear in side a paragraph.")
    )
  )
)

# define server logic --- 
server <- function(input, output){
  
}

# run the app --- 
shinyApp(ui = ui, server = server)




