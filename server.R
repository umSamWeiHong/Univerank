library(shiny)

source("main.R")

# input
# ranking_comparison_university_name
# ranking_comparison_QS
# ranking_comparison_THE

QS_unique_university_names <- (qs %>% select(University) %>% distinct() %>% arrange(University))$University
THE_unique_university_names <- (the %>% select(name) %>% distinct() %>% arrange(name))$name
malaysia_university_names <- (conversion %>% arrange(THE))$THE

shinyServer(function(input, output, session) {
  observeEvent(input$ranking_comparison_QS, {
    if (input$ranking_comparison_QS) {
      if (input$ranking_comparison_THE)
        updateSelectInput(inputId = "ranking_comparison_university_name",
                          choices = malaysia_university_names)
      else
        updateSelectInput(inputId = "ranking_comparison_university_name",
                          choices = QS_unique_university_names)
    }
  })
  observeEvent(input$ranking_comparison_THE, {
    if (input$ranking_comparison_THE) {
      if (input$ranking_comparison_QS) 
        updateSelectInput(inputId = "ranking_comparison_university_name",
                          choices = malaysia_university_names)
      else
        updateSelectInput(inputId = "ranking_comparison_university_name",
                          choices = THE_unique_university_names)
    }
  })
  
  output$ranking_comparison <- renderPlot(
    getRankingComparisonPlot(input$ranking_comparison_university_name,
                             input$ranking_comparison_QS,
                             input$ranking_comparison_THE))
})
