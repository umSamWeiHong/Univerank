library(shiny)
library(ggplot2)
library(tidyverse)

qs <- read.csv("data/QS.csv")
the <- read.csv("data/THE.csv")

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

getTHEMetricsPlot <- function(university, overall, teaching, research, citations, international_outlook, industry_income) {
  df <- the %>%
    filter(name == university) %>% 
    select(name, year, scores_overall, scores_teaching, scores_research, scores_citations, scores_industry_income, scores_international_outlook)
  print(df)
  
  plot <- ggplot(data = df, aes(x = year)) +
    ggtitle(paste("THE Metric Scores of", university, "against Year")) +
    xlab("year") +
    ylab("score")
  
  if (overall) plot = addTHEMetric(plot, df$year, df$scores_overall, "Overall")
  if (teaching) plot = addTHEMetric(plot, df$year, df$scores_teaching, "Teaching")
  if (research) plot = addTHEMetric(plot, df$year, df$scores_research, "Research")
  if (citations) plot = addTHEMetric(plot, df$year, df$scores_citations, "Citations")
  if (international_outlook) plot = addTHEMetric(plot, df$year, df$scores_international_outlook, "International Outlook")
  if (industry_income) plot = addTHEMetric(plot, df$year, df$scores_industry_income, "Industry Income")
  
  colours = c("Overall" = "deeppink",
              "Research" = "darkorange1",
              "Teaching" = "darkgoldenrod1",
              "Citations" = "darkgreen",
              "International Outlook" = "blue3",
              "Industry Income" = "blueviolet")
  
  plot <- plot +
    scale_color_manual(values = colours)
  
  return(plot)
}

addTHEMetric <- function(plot, year, metricData, metric) {
  plot <- plot +
    geom_point(mapping = aes(y = metricData, color = metric), size = 3) +
    geom_line(mapping = aes(y = metricData, color = metric), size = 2) +
    geom_text(
      aes(x = year, y = metricData, label = metricData, color = metric, fontface = "bold"),
      nudge_y = 1.8
    )
  return(plot)
}

getTHEMetricsPlot('Universiti Kebangsaan Malaysia', TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
