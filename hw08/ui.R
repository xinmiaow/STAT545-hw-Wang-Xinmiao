library(tidyverse)
library(ggthemes)

bcl_data <- read.csv("./dataset/bcl-data.csv")

ui <- fluidPage(
  # Application title
  titlePanel("BC Liquor Store prices"),
  sidebarLayout(
    sidebarPanel(
      img(src="logo1.jpg", width="100%"),
      sliderInput("priceIn", "Price", 0, 100, c(25, 40), pre = "CAD"),
      radioButtons("typeIn", "Product type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE"),
      uiOutput("countryOutput"),
      "Do you want sort the table by Price?",
      checkboxInput("sortPrice", "Sort by Price", FALSE),
      verbatimTextOutput("value")
    ),
    mainPanel(
      plotOutput("Histogram_Alcogol"),
      br(), br(),
      tableOutput("bcl_table")
    )
  )
)