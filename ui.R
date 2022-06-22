library(shiny)
library(shinythemes)
library(readr)
library(bslib)
library(DT)
library(tools)

qs <- read.csv("data/QS.csv")
the <- read.csv("data/THE.csv")

# Define UI for application that plots features of University Ranking
navbarPage(
  theme = bs_theme(bootswatch = "united"),
  
  titlePanel("Univerank - Get all University Rankings!", windowTitle = "University Ranking"),
  
  tabPanel(
    "Ranking Comparisons",
    sidebarLayout(
      sidebarPanel(
        checkboxInput("ranking_comparison_QS", "Show QS Ranking"),
        checkboxInput("ranking_comparison_THE", "Show THE Ranking"),
        selectInput("ranking_comparison_university_name", "University",
                    NULL),
      ),
      mainPanel(
        plotOutput("ranking_comparison")
      )
    )
  ),
  tabPanel(
    "Second tab name",
    sidebarPanel(
      textInput("txt", "Text input:", "text here"),
      sliderInput("slider", "Slider input:", 1, 100, 30),
      actionButton("action", "Button")
    ),
    mainPanel(

    )
  ),
  tabPanel(
    "Second tab name",
    sidebarPanel(
      textInput("txt", "Text input:", "text here"),
      sliderInput("slider", "Slider input:", 1, 100, 30),
      actionButton("action", "Button")
    ),
    mainPanel(

    )
  ),
  tabPanel(
    "Second tab name",
    sidebarPanel(
      textInput("txt", "Text input:", "text here"),
      sliderInput("slider", "Slider input:", 1, 100, 30),
      actionButton("action", "Button")
    ),
    mainPanel(

    )
  )
  
  # sidebarLayout(
  #   sidebarPanel(
  #     textInput("txt", "Text input:", "text here"),
  #     sliderInput("slider", "Slider input:", 1, 100, 30),
  #     actionButton("action", "Button"),
  #     actionButton("action2", "Button2", class = "btn-primary")
  #   ),
  # 
  #   mainPanel(
  #     tabsetPanel(
  #       tabPanel("Tab 1"),
  #       tabPanel("Tab 2", plotOutput("ranking_comparison"))
  #     )
  #   )
  # )

  # 
  # 
  # # Sidebar layout with a input and output definitions
  # sidebarLayout(
  #   
  #   # Inputs
  #   sidebarPanel(
  #     
  #     h3("Selection panel"),
  #     
  #     #can use this if "year" variable is needed ya
  #     # Select variable for year
  #     #selectInput(inputId = "year", 
  #       #           label = "Select a year: ",
  #       #          choices = c("2017", "2018", "2019", "2020","2021","2022"), 
  #         #         selected = "2018"),
  #     
  #     selectInput(inputId = "qsRanking", 
  #                 label = "Do you wish to view QS rankings? : ",
  #                 choices = qs$University,
  #                 selected = "QS Ranking"),
  #     
  #     selectInput(inputId = "theRanking", 
  #                 label = "Do you wish to view THE rankings? : ",
  #                 choices = the$name,
  #                 selected = "THE Ranking"),
  #     
  #     
  #     hr(),
  #     
  #     
  #     # Select variable for world rank
  #     sliderInput(inputId = "worldRank", 
  #                 label = "World Rank: ",
  #                 min = 1, max = 50, 
  #                 value = "25"),
  #     
  #     
  #     
  #     #you dont have to display this if it doesn't suit your liking ya @sam
  #     radioButtons("dist", "Place of study :",
  #                   c("Global Institutions" = "norm",
  #                     "National Institutions" = "unif"
  #                     )),
  #     
  #     hr(),
  #     
  #     # Show data table
  #     checkboxInput(inputId = "show_data",
  #                   label = "Display data table",
  #                   value = TRUE),
  #                   h5("This section allows the table in Data panel to be displayed or hiden
  #                       based on user preference"),
  #     
  #     br(),
  #     br(),
  #     
  #     
  #   ),
  #   
  #   # Output:
  #   mainPanel(
  # 
  #     # to be edited based on preference
  #     tabsetPanel(id = "tabspanel", type = "tabs",
  #                 tabPanel(title = "Base 1", 
  #                           br(),
  #                         # plotOutput(outputId = "tester"),
  #                           h1("Add your preference")),
  # 
  #                 tabPanel(title = "Base 2", 
  #                           
  #                           br(),
  #                           h1("Add your preference")),
  #                 
  #                 tabPanel(title = "Base 3", 
  #                           
  #                           br(),
  #                           h1("Add your preference")),
  #                 
  #                 tabPanel(title = "Data", 
  #                           br(),
  #                           DT::dataTableOutput(outputId = "testTable"),
  #                           h1("Insert table"))
  #     )
  #   )
  # )
)
