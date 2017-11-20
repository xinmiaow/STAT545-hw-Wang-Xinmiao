library(tidyverse)
library(ggthemes)
library(DT)
library(colourpicker)
library(shiny)

server <- function(input, output){
  bcl_data <- read.csv("./dataset/bcl-data.csv")
  
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl_data$Country)),
                selected="CANADA")
  }) 
  
  Filtered_bcl <- reactive({
    if (input$filterCountry) {
      if (is.null(input$countryInput)) {
        return(NULL)
      } else {
        bcl_data %>% 
          filter(Price>=input$priceIn[1], 
                 Price<=input$priceIn[2], 
                 Type==input$typeIn,
                 Country==input$countryInput)
      }
    } else {
      bcl_data %>% 
        filter(Price>=input$priceIn[1], 
               Price<=input$priceIn[2], 
               Type==input$typeIn)
    }
    
   
  })
  
  output$nrowText <- renderText({
    n <- nrow(Filtered_bcl())
    if (is.null(n)) {
      n <- 0
    }
    paste0("We found ", n, " options for you")
  })

  output$Histogram_Alcogol <- renderPlot({
    if (is.null(Filtered_bcl())) {
      return()
    }
    
    Filtered_bcl() %>% 
      ggplot(aes(x=Alcohol_Content))+
      geom_histogram(bg=input$col, col=input$col)+
      theme_calc()
  })
  
  output$bcl_table<- DT::renderDataTable({
    if (input$sortPrice){
      Filtered_bcl() %>% 
        arrange(Price)
    } else {
      Filtered_bcl()
    }
    
  })
  
  output$download <- downloadHandler(
    filename = function() {
      "bcl-results.csv"
    },
    content = function(con) {
      write.csv(Filtered_bcl(), con)
    }
  )
}
