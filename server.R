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
  
  observeEvent(input$metric_comparison_ranking_system, {
    if (input$metric_comparison_ranking_system == 'QS') {
      updateSelectInput(inputId = "metric_comparison_university_name",
                        choices = QS_unique_university_names)
      updateCheckboxGroupInput(inputId = "metric_comparison_metrics",
                               choices = list("Overall",
                                              "Academic Reputation",
                                              "Employer Reputation",
                                              "Faculty Student Ratio",
                                              "Citations per Faculty",
                                              "International Faculty Ratio",
                                              "International Students Ratio"))
    }
    if (input$metric_comparison_ranking_system == 'THE') {
      updateSelectInput(inputId = "metric_comparison_university_name",
                        choices = THE_unique_university_names)
      updateCheckboxGroupInput(inputId = "metric_comparison_metrics",
                               choices = list("Overall",
                                              "Research",
                                              "Teaching",
                                              "Citations",
                                              "International Outlook",
                                              "Industry Income"))
    }
  })
  
  output$ranking_comparison <- renderPlot(
    getRankingComparisonPlot(input$ranking_comparison_university_name,
                             input$ranking_comparison_QS,
                             input$ranking_comparison_THE))
  
  output$metric_comparison <- renderPlot(
    getMetricComparisonPlot(input)
  )
})

getMetricComparisonPlot <- function(input) {
  ranking_system = input$metric_comparison_ranking_system
  university_name = input$metric_comparison_university_name
  metrics = input$metric_comparison_metrics
  
  if (ranking_system == 'QS') {
    overall <- "Overall" %in% metrics
    academic_reputation <- "Academic Reputation" %in% metrics
    employer_reputation <- "Employer Reputation" %in% metrics
    faculty_student_ratio <- "Faculty Student Ratio" %in% metrics
    citations_per_faculty <- "Citations per Faculty" %in% metrics
    international_faculty_ratio <- "International Faculty Ratio" %in% metrics
    international_students_ratio <- "International Students Ratio" %in% metrics
    
    plot <- getQSMetricsPlot(university_name, overall,
                             academic_reputation, employer_reputation, faculty_student_ratio,
                             citations_per_faculty, international_faculty_ratio, international_students_ratio)
    return(plot)
  }
  if (ranking_system == 'THE') {
    overall <- "Overall" %in% metrics
    teaching <- "Research" %in% metrics
    research <- "Teaching" %in% metrics
    citations <- "Citations" %in% metrics
    international_outlook <- "International Outlook" %in% metrics
    industry_income <- "Industry Income" %in% metrics
    
    plot <- getTHEMetricsPlot(university_name, overall, teaching, research, citations, international_outlook, industry_income)
    return(plot)
  }
}


