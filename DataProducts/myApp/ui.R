
# Define UI for application 
library(shiny)

shinyUI(fluidPage(
  titlePanel("Birthday calculator"),
  
  column(4, wellPanel(
    dateInput('date',
              label = 'Enter your birthday: yyyy-mm-dd',
              value = Sys.Date()))),
  column(8,
         verbatimTextOutput("dateText")),
)
)




