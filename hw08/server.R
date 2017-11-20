library(tidyverse)
library(ggthemes)

server <- function(input, output){
  bcl_data <- read.csv("./dataset/bcl-data.csv")
  
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl_data$Country)),
                selected="CANADA")
  }) 
  
  Filtered_bcl <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    } 
    
    bcl_data %>% 
      filter(Price>=input$priceIn[1], 
             Price<=input$priceIn[2], 
             Type==input$typeIn,
             Country==input$countryInput)
  })

  output$Histogram_Alcogol <- renderPlot({
    if (is.null(Filtered_bcl())) {
      return()
    }
    
    Filtered_bcl() %>% 
      ggplot(aes(x=Alcohol_Content))+
      geom_histogram()+
      theme_calc()
  })
  
  output$bcl_table<- renderTable({
    if (input$sortPrice){
      Filtered_bcl() %>% 
        arrange(Price)
    } else {
      Filtered_bcl()
    }
    
  })
}