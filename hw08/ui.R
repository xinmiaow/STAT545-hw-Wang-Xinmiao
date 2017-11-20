library(tidyverse)
library(ggthemes)
library(DT)
library(colourpicker)
library(shiny)
library(shinythemes)

bcl_data <- read.csv("./dataset/bcl-data.csv")

ui <- fluidPage(
  # Themes
  theme = shinytheme("simplex"),
  # Application title
  titlePanel("BC Liquor Store Prices"),
  sidebarLayout(
    sidebarPanel(
      img(src="logo1.jpg", width="100%"),
      hr(),
      sliderInput("priceIn", "Price", 0, 100, c(25, 40), pre = "CAD"),
      radioButtons("typeIn", "Product type",
                   choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                   selected = "WINE"),
      checkboxInput("filterCountry", "Filter by Country", FALSE),
      conditionalPanel(
        condition = "input.filterCountry",
        uiOutput("countryOutput")
      ),
      "Do you want sort the table by Price?",
      checkboxInput("sortPrice", "Sort by Price", FALSE),
      verbatimTextOutput("value"),
      colourInput("col", "Select colour", "#CC0E0ED6", allowTransparent = TRUE)
    ),
    mainPanel(
      h4(textOutput("nrowText")),
      tabsetPanel(
        tabPanel("Plot", br(), plotOutput("Histogram_Alcogol")),
        tabPanel("Table", br(), downloadButton("download", "Download results"), hr(), DT::dataTableOutput("bcl_table")),
        type = "tabs"
      )
    )
  )
)