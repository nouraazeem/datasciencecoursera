# Creating an app that will tell you how old you are and what your horoscope is
# as well as what your horoscope says about you


library(shiny)
shinyServer(function(input, output) {

  
  output$dateText  <- renderText({
    paste("Your birthday is ", as.character(input$date), "and you are ", round(((Sys.Date() - input$date) /365), digits = 2),"years old")
  })  
  
  
}
)