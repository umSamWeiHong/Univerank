library(dplyr)
library(ggplot2)
library(tidyverse)

qs <- read.csv("data/QS.csv")
the <- read.csv("data/THE.csv")

getQSMetricsPlot <- function(university, overall, academic_reputation, employer_reputation, faculty_student_ratio,
                             citations_per_faculty, international_faculty_ratio, international_students_ratio) {
  df <- qs %>%
    filter(University == university) %>% 
    select(University, Year, Overall.Score, Academic.Reputation, Employer.Reputation, Faculty.Student.Ratio,
           Citations.per.Faculty, International.Faculty.Ratio, International.Students.Ratio)
  print(df)

  # Return an empty plot with text if university is not found.
  if (nrow(df) == 0)
    return (ggplot() +
              annotate("text", x = 4, y = 25, size = 8, colour = "red",
                       label = "University is not found. Try other options.") + 
              theme_void())

  plot <- ggplot(data = df, aes(x = Year)) +
    ggtitle(paste("QS Metric Scores of", university, "against Year")) +
    xlab("year") +
    ylab("score")

  if (overall) plot <- addMetricLine(plot, df$Year, df$Overall.Score, "Overall")
  if (academic_reputation) plot <- addMetricLine(plot, df$Year, df$Academic.Reputation, "Academic Reputation")
  if (employer_reputation) plot <- addMetricLine(plot, df$Year, df$Employer.Reputation, "Employer Reputation")
  if (faculty_student_ratio) plot <- addMetricLine(plot, df$Year, df$Faculty.Student.Ratio, "Faculty Student Ratio")
  if (citations_per_faculty) plot <- addMetricLine(plot, df$Year, df$Citations.per.Faculty, "Citations per Faculty")
  if (international_faculty_ratio) plot <- addMetricLine(plot, df$Year, df$International.Faculty.Ratio, "International Faculty Ratio")
  if (international_students_ratio) plot <- addMetricLine(plot, df$Year, df$International.Students.Ratio, "International Students Ratio")

  colours = c("Overall" = "deeppink",
              "Academic Reputation" = "darkorange1",
              "Employer Reputation" = "darkgoldenrod1",
              "Faculty Student Ratio" = "darkgreen",
              "Citations per Faculty" = "blue3",
              "International Faculty Ratio" = "blueviolet",
              "International Students Ratio" = "darkmagenta")

  plot <- plot +
    scale_color_manual(values = colours)

  return(plot)
}

getTHEMetricsPlot <- function(university, overall, teaching, research, citations, international_outlook, industry_income) {
  df <- the %>%
    filter(name == university) %>% 
    select(name, year, scores_overall, scores_teaching, scores_research, scores_citations, scores_international_outlook, scores_industry_income)
  print(df)
  
  # Return an empty plot with text if university is not found.
  if (nrow(df) == 0)
    return (ggplot() +
              annotate("text", x = 4, y = 25, size = 8, colour = "red",
                       label = "University is not found. Try other options.") + 
              theme_void())

  plot <- ggplot(data = df, aes(x = year)) +
    ggtitle(paste("THE Metric Scores of", university, "against Year")) +
    xlab("year") +
    ylab("score")
  
  if (overall) plot <- addMetricLine(plot, df$year, df$scores_overall, "Overall")
  if (teaching) plot <- addMetricLine(plot, df$year, df$scores_teaching, "Teaching")
  if (research) plot <- addMetricLine(plot, df$year, df$scores_research, "Research")
  if (citations) plot <- addMetricLine(plot, df$year, df$scores_citations, "Citations")
  if (international_outlook) plot <- addMetricLine(plot, df$year, df$scores_international_outlook, "International Outlook")
  if (industry_income) plot <- addMetricLine(plot, df$year, df$scores_industry_income, "Industry Income")
  
  colours = c("Overall" = "deeppink",
              "Research" = "darkorange1",
              "Teaching" = "darkgoldenrod1",
              "Citations" = "darkgreen",
              "International Outlook" = "blue3",
              "Industry Income" = "blueviolet")
  
  plot <- plot +
    theme(plot.title = element_text(hjust = 0.5)) +
    scale_color_manual(values = colours)
  
  return(plot)
}

addMetricLine <- function(plot, year, metricData, metric) {
  plot <- plot +
    geom_point(mapping = aes(y = metricData, color = metric), size = 3) +
    geom_line(mapping = aes(y = metricData, color = metric), size = 2) +
    geom_text(
      aes(x = year, y = metricData, label = metricData, color = metric, fontface = "bold"),
      nudge_y = 1.8
    )
  return(plot)
}

getRankingComparisonPlot <- function(university, QS, THE) {
  df_qs <- qs %>%
    filter(University == university) %>%
    select(University, Year, Ranking)
  print(df_qs)

  df_the <- the %>%
    filter(name == university) %>%
    select(name, year, rank)
  print(df_the)
    
  plot <- ggplot() +
    ggtitle(paste("Ranking of", university, "against Year")) +
    xlab("year") +
    ylab("ranking")
  
  colours <- NULL

  if (QS) {
    # Return an empty plot with text if university is not found in QS.
    if (nrow(df_qs) == 0)
      return(ggplot() +
                annotate("text", x = 4, y = 25, size = 8, colour = "red",
                        label = "University is not found in our QS dataset.\nTry other options.") + 
                theme_void())

    plot <- plot +
              geom_point(data = df_qs, mapping = aes(x = Year, y = Ranking, color = "QS"), size = 3) +
              geom_line(data = df_qs, mapping = aes(x = Year, y = Ranking, color = "QS"), size = 2) +
              geom_text(
                data = df_qs,
                aes(x = Year, y = Ranking, label = Ranking, color = "QS", fontface = "bold"),
                nudge_y = 0.5
              )
    colours <- append(colours, c("QS" = "coral"))
  }
  if (THE) {
    # Return an empty plot with text if university is not found in THE.
      if (nrow(df_the) == 0)
        return(ggplot() +
                  annotate("text", x = 4, y = 25, size = 8, colour = "red",
                          label = "University is not found in our THE dataset.\nTry other options.") + 
                  theme_void())

    plot <- plot +
              geom_point(data = df_the, mapping = aes(x = year, y = rank, colour = "THE"), size = 3) +
              geom_line(data = df_the, mapping = aes(x = year, y = rank, colour = "THE"), size = 2) +
              geom_text(
                data = df_the,
                aes(x = year, y = rank, label = rank, colour = "THE", fontface = "bold"),
                nudge_y = 0.5
              )
    colours <- append(colours, c("THE" = "darkturquoise"))
  }
  
  plot <- plot +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(colour = "Ranking System") +
    scale_colour_manual(values = colours)
    # scale_y_reverse()
  
  return(plot)
}

getQSComparisonPlot <- function(universities, year) {
  
}

getTHEComparisonPlot <- function(universities, year,
                                 overall, teaching, research, citations, international_outlook, industry_income) {
  currentYear <- year
  df <- the %>%
    filter((name %in% universities) & year == currentYear) %>% 
    select(name, scores_overall, scores_teaching, scores_research, scores_citations, scores_international_outlook, scores_industry_income)
  print(df)
  
  # Return an empty plot with text if some data is missing
  if (nrow(df) != length(universities))
    return (ggplot() +
              annotate("text", x = 4, y = 25, size = 8, colour = "red",
                       label = "Missing Data. Try other options.") + 
              theme_void())
  
  plot <- ggplot(data = df) +
    ggtitle(paste("Comparison of THE Metric Scores in year", currentYear)) +
    xlab("score") +
    ylab("metric")
  
  limits = c()
  
  if (overall) {
    plot <- addMetricBar(plot, universities, year, df$scores_overall, "Overall")
    limits <- append(limits, "Overall")
  }
  if (teaching) {
    plot <- addMetricBar(plot, universities, year, df$scores_teaching, "Teaching")
    limits <- append(limits, "Teaching")
  }
  if (research) {
    plot <- addMetricBar(plot, universities, year, df$scores_research, "Research")
    limits <- append(limits, "Research")
  }
  if (citations) {
    plot <- addMetricBar(plot, universities, year, df$scores_citations, "Citations")
    limits <- append(limits, "Citations")
  }
  if (international_outlook) {
    plot <- addMetricBar(plot, universities, year, df$scores_international_outlook, "International Outlook")
    limits <- append(limits, "International Outlook")
  }
  if (industry_income) {
    plot <- addMetricBar(plot, universities, year, df$scores_industry_income, "Industry Income")
    limits <- append(limits, "Industry Income")
  }
  
  print(limits)
  
  plot <- plot +
    scale_y_discrete(limits = rev(limits)) +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme(legend.position = "bottom")
  
  return(plot)
}

addMetricBar <- function(plot, universities, year, metricData, metric) {
  plot <- plot +
    geom_bar(aes(x = metricData, y = metric, fill = universities), stat = "identity", position = position_dodge()) +
    geom_text(aes(x = metricData, y = metric, label = sprintf("%0.1f", round(metricData, digits = 1)), group = universities),
              hjust = 1.3, size = 4, fontface = "bold",
              position = position_dodge2(width = 0.9, preserve = "single"))
  return(plot)
}

# getTHEComparisonPlot(c('University of Malaya', 'Universiti Kebangsaan Malaysia', 'Universiti Sains Malaysia'), 2018,
                     # TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
# getTHEMetricsPlot('Universiti Kebangsaan Malaysia', TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
getRankingComparisonPlot("University of Cambridge", TRUE, TRUE)
# getQSMetricsPlot('Universiti Kebangsaan Malaysia (UKM)', TRUE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE)
# getQSMetricsPlot('Universiti Malaya (UM)', FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)

