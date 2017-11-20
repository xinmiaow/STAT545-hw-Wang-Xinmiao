ui <- fluidPage(
  # Application title
  titlePanel("My liquor webpage"),
  
  sidebarPanel("This is my sidebar",
               sliderInput("priceIn", "Price of booze", 
                           min=0, max=300, value=c(10,20), pre="CAD"),
               radioButtons("typeIn", "What kind of booze?",
                            choices=c("BEER", "SPIRITS", "WINE"),
                            selected="SPIRITS")
  ),
  
  mainPanel(plotOutput("Histogram_Alcogol"),
            br(), br(),
            tableOutput("table_head"))
)