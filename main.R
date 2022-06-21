library(dplyr)
library(ggplot2)
library(tidyverse)

<<<<<<< HEAD
qs <- read.csv("data/QS.csv")
the <- read.csv("data/THE.csv")

getTHEMetricsPlot <- function(university, overall, teaching, research, citations, international_outlook, industry_income) {
  df <- the %>%
    filter(name == university) %>% 
    select(name, year, scores_overall, scores_teaching, scores_research, scores_citations, scores_industry_income, scores_international_outlook)
=======
qs2017 <- read.csv("data/qs_2017.csv")
qs2018 <- read.csv("data/qs_2018.csv")
qs2019 <- read.csv("data/qs_2019.csv")
qs2020 <- read.csv("data/qs_2020.csv")
qs2021 <- read.csv("data/qs_2021.csv")
the <- read.csv("data/the.csv")

getTHEMetricsPlot <- function(university, teaching, research, citations, international_outlook, industry_income) {
  df <- the %>%
    filter(name == university) %>% 
    select(name, year, scores_overall, scores_teaching, scores_research, scores_citations, scores_industry_income, scores_international_outlook)
  print(df)
>>>>>>> 0e94ea40e37c797752afb927a8a4f5468af0d607
  
  plot <- ggplot(data = df, aes(x = year)) +
          ggtitle(paste("THE Metric Scores of", university, "against Year")) +
          xlab("year") +
          ylab("score")
  
<<<<<<< HEAD
  if (overall) plot = addMetric(plot, df$year, df$scores_overall, "Overall")
  if (teaching) plot = addMetric(plot, df$year, df$scores_teaching, "Teaching")
  if (research) plot = addMetric(plot, df$year, df$scores_research, "Research")
=======
  if (research) plot = addMetric(plot, df$year, df$scores_research, "Research")
  if (teaching) plot = addMetric(plot, df$year, df$scores_teaching, "Teaching")
>>>>>>> 0e94ea40e37c797752afb927a8a4f5468af0d607
  if (citations) plot = addMetric(plot, df$year, df$scores_citations, "Citations")
  if (international_outlook) plot = addMetric(plot, df$year, df$scores_international_outlook, "International Outlook")
  if (industry_income) plot = addMetric(plot, df$year, df$scores_industry_income, "Industry Income")
  
<<<<<<< HEAD
  colours = c("Overall" = "deeppink",
              "Research" = "darkorange1",
              "Teaching" = "darkgoldenrod1",
              "Citations" = "darkgreen",
              "International Outlook" = "blue3",
              "Industry Income" = "blueviolet")
  
  plot <- plot +
    scale_color_discrete(breaks = c("Overall", "Teaching", "Research", "Citations", "International Outlook", "Industry Income")) +
    scale_color_manual(values = colours)
    
=======
>>>>>>> 0e94ea40e37c797752afb927a8a4f5468af0d607
  return(plot)
}

addMetric <- function(plot, year, metricData, metric) {
  plot <- plot +
<<<<<<< HEAD
    geom_point(mapping = aes(y = metricData, color = metric), size = 3) +
    geom_line(mapping = aes(y = metricData, color = metric), size = 2) +
    geom_text(
      aes(x = year, y = metricData, label = metricData, color = metric, fontface = "bold"),
=======
    geom_point(mapping = aes(y = metricData), size = 3) +
    geom_line(mapping = aes(y = metricData, color = metric), size = 2) +
    geom_text(
      aes(x = year, y = metricData, label = metricData),
>>>>>>> 0e94ea40e37c797752afb927a8a4f5468af0d607
      nudge_y = 1.5
    )
  return(plot)
}

<<<<<<< HEAD
getTHEComparison <- function(universities, currentYear) {
  df <- the %>%
    filter((name %in% universities) & year == currentYear) %>% 
    select(name, scores_overall, scores_teaching, scores_research, scores_citations, scores_industry_income, scores_international_outlook)
  print(df)
  plot <- ggplot(data = df) +
    ggtitle(paste("Comparison of THE Metric Scores in year", currentYear)) +
    xlab("metric") +
    ylab("score") +
    geom_bar(aes(x = 'Teaching', y = scores_teaching, fill = name), stat = "identity", position = position_dodge()) +
    geom_text(aes(x = 'Teaching', y = scores_teaching, label = scores_teaching, fill = name), vjust = 2, size = 4, position = position_dodge2(width = 0.9, preserve = "single")) +
    geom_bar(aes(x = 'Research', y = scores_research, fill = name), stat = "identity", position = position_dodge()) + 
    geom_text(aes(x = 'Research', y = scores_research, label = scores_research, fill = name), vjust = 2, size = 4, position = position_dodge2(width = 0.9, preserve = "single"))
    
    
    
    # geom_bar(aes(x = scores_teaching))
  return(plot)
}

# getTHEComparison(c('University of Malaya', 'Universiti Kebangsaan Malaysia', 'Universiti Sains Malaysia'), 2021)
getTHEMetricsPlot('Universiti Kebangsaan Malaysia', TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
# getTHEMetricsPlot('Universiti Kebangsaan Malaysia', TRUE, TRUE, TRUE, FALSE, FALSE, FALSE)
=======
getTHEMetricsPlot('University of Malaya', TRUE, TRUE, TRUE, TRUE, TRUE)
>>>>>>> 0e94ea40e37c797752afb927a8a4f5468af0d607
