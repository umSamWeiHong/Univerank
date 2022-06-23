library(shiny)

source("main.R")

# input
# ranking_comparison_university_name
# ranking_comparison_QS
# ranking_comparison_THE

QS_unique_university_names <- (qs %>% select(University) %>% distinct() %>% arrange(University))$University
THE_unique_university_names <- (the %>% select(name) %>% distinct() %>% arrange(name))$name
malaysia_university_names <- (conversion %>% arrange(THE))$THE

QS_unique_country_names <- (qs %>% select(Location) %>% distinct() %>% arrange(Location))$Location
THE_unique_country_names <- (the %>% select(location) %>% distinct() %>% arrange(location))$location

documentation <- 
"This manual is structured to ensure that users have a complete idea using our application.

Ranking Comparison
In this section, users can compare the change of a university's rankings from 2017 to 2021.
1. Select a ranking system of QS or THE. If both are chosen, then only Malaysia universities will be available.
2. Select an university present in the chosen ranking system(s).

Metric Comparison
In this section, users can compare the change of a university's metric scores from 2017 to 2021.
1. Select a ranking system of either QS or THE.
2. Select an university present in the chosen ranking system.
3. Select the metric(s) to be displayed on the plot.

University Comparison
In this section, users can compare three different universities' metric scores in a specified year.
1. Select a ranking system of either QS or THE.
2. Select three different universities present in the chosen ranking system.
3. Choose a year where the scores are taken.
4. Select the metric(s) to be displayed on the plot.

Country Comparison
In this section, users can compare the ranking or overall scores of top n universies in a specified country and year.
1. Select a ranking system of either QS or THE.
2. Select a country present in the chosen ranking system.
3. Choose a year where the rankings are taken.
4. Select the range of n, that is the top n universities to be shown.
5. Select whether to display the ranking or overall scores on the plot."

shinyServer(function(input, output, session) {
  observeEvent(input$ranking_comparison_ranking_system, {
    if ('QS' %in% input$ranking_comparison_ranking_system) {
      updateSelectInput(inputId = "ranking_comparison_university_name",
                        choices = QS_unique_university_names)
    }
    if ('THE' %in% input$ranking_comparison_ranking_system) {
      updateSelectInput(inputId = "ranking_comparison_university_name",
                        choices = THE_unique_university_names)
    }
    if ('QS' %in% input$ranking_comparison_ranking_system 
        & 'THE' %in% input$ranking_comparison_ranking_system) {
      updateSelectInput(inputId = "ranking_comparison_university_name",
                        choices = malaysia_university_names)
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
  observeEvent(input$country_comparison_ranking_system, {
    if (input$country_comparison_ranking_system == 'QS') {
      updateSelectInput(inputId = "country_comparison_country",
                        choices = QS_unique_country_names)
    }
    if (input$country_comparison_ranking_system == 'THE') {
      updateSelectInput(inputId = "country_comparison_country",
                        choices = THE_unique_country_names)
    }
  })
  observeEvent(input$country_comparison_country, {
    df <- qs %>%
      filter(Location == input$country_comparison_country 
             & Year == input$country_comparison_year)
    updateSliderInput(inputId = "country_comparison_number",
                      max = nrow(df))
  })
  observeEvent(input$country_comparison_year, {
    df <- qs %>%
      filter(Location == input$country_comparison_country 
             & Year == input$country_comparison_year)
    updateSliderInput(inputId = "country_comparison_number",
                      max = nrow(df))
  })
  observeEvent(input$university_comparison_ranking_system, {
    if (input$university_comparison_ranking_system == 'QS') {
      updateSelectInput(inputId = "university_comparison_university_name1",
                        choices = QS_unique_university_names)
      updateSelectInput(inputId = "university_comparison_university_name2",
                        choices = QS_unique_university_names)
      updateSelectInput(inputId = "university_comparison_university_name3",
                        choices = QS_unique_university_names)
      updateCheckboxGroupInput(inputId = "university_comparison_metrics",
                               choices = list("Overall",
                                              "Academic Reputation",
                                              "Employer Reputation",
                                              "Faculty Student Ratio",
                                              "Citations per Faculty",
                                              "International Faculty Ratio",
                                              "International Students Ratio"))
    }
    if (input$university_comparison_ranking_system == 'THE') {
      updateSelectInput(inputId = "university_comparison_university_name1",
                        choices = THE_unique_university_names)
      updateSelectInput(inputId = "university_comparison_university_name2",
                        choices = THE_unique_university_names)
      updateSelectInput(inputId = "university_comparison_university_name3",
                        choices = THE_unique_university_names)
      updateCheckboxGroupInput(inputId = "university_comparison_metrics",
                               choices = list("Overall",
                                              "Research",
                                              "Teaching",
                                              "Citations",
                                              "International Outlook",
                                              "Industry Income"))
    }
  })
  
  output$documentation <- renderText(documentation)
  
  output$description <- renderText(
    getLocation(input$ranking_comparison_university_name)
  )
  
  output$ranking_comparison <- renderPlot(
    getRankingComparisonPlot(input$ranking_comparison_university_name,
                             'QS' %in% input$ranking_comparison_ranking_system,
                             'THE' %in% input$ranking_comparison_ranking_system))
  
  output$metric_comparison <- renderPlot(
    getMetricComparisonPlot(input)
  )
  
  output$country_comparison <- renderPlot(
    getCountryComparisonPlot(input)
  )
  
  output$university_comparison <- renderPlot(
    getUniversityComparisonPlot(input)
  )
})

getMetricComparisonPlot <- function(input) {
  ranking_system <- input$metric_comparison_ranking_system
  university_name <- input$metric_comparison_university_name
  metrics <- input$metric_comparison_metrics
  
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

getCountryComparisonPlot <- function(input) {
  ranking_system <- input$country_comparison_ranking_system
  country <- input$country_comparison_country
  year <- input$country_comparison_year
  start <- input$country_comparison_number[1]
  end <- input$country_comparison_number[2]
  print(start)
  print(end)
  
  if ('Ranking' %in% input$country_comparison_show_ranking)
    show_ranking <- TRUE
  else
    show_ranking <- FALSE
  
  if (ranking_system == 'QS') {
    plot <- getQSCountryComparisonPlot(country, year, show_ranking, start, end)
    return(plot)
  }
  if (ranking_system == 'THE') {
    plot <- getTHECountryComparisonPlot(country, year, show_ranking, start, end)
    return(plot)
  }
}

getUniversityComparisonPlot <- function(input) {
  ranking_system <- input$university_comparison_ranking_system
  university_name1 <- input$university_comparison_university_name1
  university_name2 <- input$university_comparison_university_name2
  university_name3 <- input$university_comparison_university_name3
  year <- input$university_comparison_year
  metrics <- input$university_comparison_metrics
  
  
  if (length(metrics) == 0)
    return(ggplot())
  
  universities <- NULL
  
  if (!is.null(university_name1)) universities <- append(universities, university_name1)
  if (!is.null(university_name2)) universities <- append(universities, university_name2)
  if (!is.null(university_name3)) universities <- append(universities, university_name3)
  
  if (ranking_system == 'QS') {
    overall <- "Overall" %in% metrics
    academic_reputation <- "Academic Reputation" %in% metrics
    employer_reputation <- "Employer Reputation" %in% metrics
    faculty_student_ratio <- "Faculty Student Ratio" %in% metrics
    citations_per_faculty <- "Citations per Faculty" %in% metrics
    international_faculty_ratio <- "International Faculty Ratio" %in% metrics
    international_students_ratio <- "International Students Ratio" %in% metrics
    
    plot <- getQSUniversityComparisonPlot(universities, year, overall,
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
    
    plot <- getTHEUniversityComparisonPlot(universities, year,
                                           overall, teaching, research, citations, international_outlook, industry_income)
    return(plot)
  }
}
