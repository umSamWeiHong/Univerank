library(shiny)
library(shinythemes)
library(readr)
library(bslib)
library(DT)
library(tools)

# Define UI for application that plots features of University Ranking
navbarPage(
  theme = bs_theme(bootswatch = "united"),
  
  titlePanel("Univerank - Get all University Rankings!", windowTitle = "University Ranking"),
  
  tabPanel(
    "Ranking Comparison",
    sidebarLayout(
      sidebarPanel(
        checkboxGroupInput("ranking_comparison_ranking_system", "Ranking System", list('QS', 'THE')),
        selectInput("ranking_comparison_university_name", "University", NULL),
      ),
      mainPanel(
        verbatimTextOutput("description"),
        plotOutput("ranking_comparison")
      )
    )
  ),
  tabPanel(
    "Metric Comparison",
    sidebarLayout(
      sidebarPanel(
        selectInput("metric_comparison_ranking_system", "Ranking System", list('QS', 'THE')),
        selectInput("metric_comparison_university_name", "University", NULL),
        checkboxGroupInput("metric_comparison_metrics", "Metrics", NULL),
      ),
      mainPanel(
        plotOutput("metric_comparison")
      )
    )
  ),
  tabPanel(
    "University Comparison",
    sidebarLayout(
      sidebarPanel(
        selectInput("university_comparison_ranking_system", "Ranking System", list('QS', 'THE')),
        selectInput("university_comparison_university_name1", "University 1", NULL),
        selectInput("university_comparison_university_name2", "University 2", NULL),
        selectInput("university_comparison_university_name3", "University 3", NULL),
        sliderInput("university_comparison_year", "Year", 2017, 2021, value = 2021, step = 1),
        checkboxGroupInput("university_comparison_metrics", "Metrics", NULL)
      ),
      mainPanel(
        plotOutput("university_comparison")
      )
    )
  ),
  tabPanel(
    "Country Comparison",
    sidebarLayout(
      sidebarPanel(
        selectInput("country_comparison_ranking_system", "Ranking System", list('QS', 'THE')),
        selectInput("country_comparison_country", "Country", NULL),
        sliderInput("country_comparison_year", "Year", 2017, 2021, value = 2021, step = 1),
        sliderInput("country_comparison_number", "Top n universitites", 1, 50, value = c(1, 5), step = 1),
        radioButtons("country_comparison_show_ranking", "Show", choices = list('Ranking', 'Overall Score'))
      ),
      mainPanel(
        plotOutput("country_comparison")
      )
    )
  ),
  tabPanel(
    "Documentation",
    sidebarLayout(
      sidebarPanel(
        
      ),
      mainPanel(
        textOutput("documentation")
      )
    )
  )
)
