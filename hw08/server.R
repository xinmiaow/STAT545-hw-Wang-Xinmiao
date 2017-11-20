library(tidyverse)

server <- function(input, output){
  bcl_data <- read.csv("./myfiles/bcl-data.csv")
  Filtered_bcl <- reactive({bcl_data %>% 
      filter(Price>=input$priceIn[1], 
             Price<=input$priceIn[2], 
             Type==input$typeIn)
  })
  output$Histogram_Alcogol <- renderPlot({
    Filtered_bcl() %>% 
      ggplot(aes(x=Alcohol_Content))+
      geom_histogram()
  })
  output$table_head <- renderTable({
    Filtered_bcl() %>% 
      head()
  })
}