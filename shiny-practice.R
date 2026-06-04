# #shiny practice app 
# #sara
# #2026-06-4
# 
# #load libraries 
# #install.packages(c("shiny", "shinythemes", "shinyjs")) since it is a lot of libraries it is better to 
# #do that in the console
# # library("tidyverse")
# library("shiny")
# 
# #UI: layout and inputs/outputs go here
# 
# ui <- fluidPage(
#   #add UI code here
#   textOutput(outputId="greeting") #the word greeting will be used in the server after the dollar sign
# 
# )
# 
# 
# #server: logic and reactivity go here
# 
# server <-  function(input, output) {
#   #add server code
#   output$greeting <- renderText({
#     "Hello, World" #application content
#   })
# }
# 
# #launch the app 
# 
# shinyApp(ui, server)

# load libraries
library(shiny)
library(shinythemes)
library(shinyjs)
library(tidyverse)

# UI: Layout and inputs/outputs go here
ui <- fluidPage(
  titlePanel("exploring the normal distribution"),
  plotOutput(outputId = "normal_plot"),
  textOutput(outputId = "context_discussion")
  # add ui code here
)

# Server: logic, and reactivity go here
server <- function(input, output) {
  # Add server code
  output$normal_plot <- renderPlot({
    # create normal vector
    set.seed(seed = 7)
    samples <- rnorm(1000, mean = 0, sd = 1)
    
    # make a histogram
    hist(samples,
         breaks = 30,
         col = "maroon",
         main = "Histogram of normal samples",
         xlab = "Value")
  })
  output$context_discussion <- renderText({
  "this is the discussion description to add more context so I can see if it goes dwn the image" 
    })

#add context 

}

# Launch the app
shinyApp(ui, server)