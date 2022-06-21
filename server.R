library(shiny)

qs2017 <- read.csv("data/qs_2017.csv")
qs2018 <- read.csv("data/qs_2017.csv")
qs2019 <- read.csv("data/qs_2017.csv")
qs2020 <- read.csv("data/qs_2017.csv")
qs2021 <- read.csv("data/qs_2017.csv")
the <- read.csv("data/the.csv")

shinyServer(function(input, output) {
  # Display data table when box is checked
  observeEvent(input$show_data, {
    if(input$show_data){
      showTab(inputId = "tabspanel", target = "Data", select = TRUE)
    } else {
      hideTab(inputId = "tabspanel", target = "Data")
    }
  })
})
