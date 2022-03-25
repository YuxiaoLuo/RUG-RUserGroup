############################
# Exercise 1

# define ui
ui <- fluidPage(
  titlePanel("RUG (R User Group)"),
  sidebarLayout(
    sidebarPanel(
      h1("Introducing RUG"),
      p("R User’s Group (i.e., RUG) is a place for newbies and experts 
        alike to learn and work together on projects using the 
        statistical programming language, R."),
      br(),
      code("install.packages('shiny')"),
      br(),br(),
      img(src = "1215.jpg", height = 150, width = 150),
      p("Join RUG at", a(href = "RUG","http://cuny.is/rug"))
    ),
    mainPanel(
      h1("Meeting Schedule"),
      strong("We are meeting on Friday 3-4 pm bi-weekly."),
      h2("Meeting topics"),
      hr("- Shiny"), p("- Markdown"), p("etc...") 
    )
  )
)

# define server function
server <- function(input, output){
  
}
  
# run the App
shinyApp(ui = ui, server = server)

