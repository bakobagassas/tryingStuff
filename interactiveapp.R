# load libraries
library(shiny)
library(shinythemes)
library(shinyjs)
library(tidyverse)

# ui
ui <- fluidPage(
  titlePanel("interactive greeting application"),
  
  textInput(
    inputId = "user_input",
    label = "Enter your greeting:",
    value = "Hello, World!"
  ),
  
  textOutput(outputId = "greeting")
)

# server
server <- function(input, output) {
  output$greeting <- renderText({
    paste0(input$user_input)
  })
}

# Launch the app
shinyApp(ui, server)
  