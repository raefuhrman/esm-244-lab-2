library(shiny)
library(tidyverse)
library(shinythemes)
library(RColorBrewer)

marvel <- read_csv("marvel-wikia-data.csv")
marvel$SEX[(is.na(marvel$SEX))] <- "Not Specified"

#create the user interface
ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("Marvel Characters"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("side",
                   "choose a side",
                   c("Good Characters",
                     "Bad Characters",
                     "Neutral Characters"))
    ),
    mainPanel(
      plotOutput(outputID = "marvelplot")
    )
  )
  
)

server <- function(input,outputs){
  
  output$marvelplot <- renderPlot({
    
    ggplot(filter(marvel, ALIGN == input$side), aes(x=Year)) +
      geom_bar(aes(fill = SEX), position = "fill")+
  }
    
  )
  
}

# Run the application 
shinyApp(ui = ui, server = server)

