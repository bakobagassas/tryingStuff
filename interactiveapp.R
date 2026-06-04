library(shiny)

ui <- fluidPage(
  titlePanel("interactive greeting application"),
  
  radioButtons( # or selectInput
    inputId = "user_input",
    label = "Choose a greeting:",
    choices = c("Hello", "Ca va", "Yaneh", "Matno"),
    selected = "Matno"
  ),
  
  textInput(inputId = "name",
            label="what is your name"),
  
  textOutput(outputId ="greeting")
)

server <- function(input, output) {
  output$greeting <- renderText({
    paste(input$user_input, input$name)
  })
}

shinyApp(ui, server)
  