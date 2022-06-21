library(shiny)
library(shinythemes)
library(readr)
library(DT)
library(tools)

dataWIE <- read.csv("data\\the.csv")

# Define UI for application that plots features of University Ranking
ui <- fluidPage(theme = bslib::bs_theme(bootswatch = "superhero"),
                
                titlePanel("World University Ranking!", windowTitle = "University Ranking"),
                
                # Sidebar layout with a input and output definitions
                sidebarLayout(
                  
                  # Inputs
                  sidebarPanel(
                    
                    h3("Selection panel"),      
                    
                    # Select variable for year
                    selectInput(inputId = "year", 
                                label = "Select a year: ",
                                choices = c("2017", "2018", "2019", "2020","2021","2022"), 
                                selected = "2018"),
                    
                    selectInput(inputId = "rankingType", 
                                label = "Do you wish to view QS or THE rankings? : ",
                                choices = c("QS Ranking", "THE Ranking"), 
                                selected = "QS Ranking"), 
                    hr(),
                   
                    # Select variable for world rank
                    sliderInput(inputId = "worldRank", 
                                label = "World Rank: ",
                                min = 1, max = 50, 
                                value = "25"),
                    
                    radioButtons("dist", "Place of study :",
                                 c("Global Institutions" = "norm",
                                   "National Institutions" = "unif"
                                   )),
                    
                    hr(),
                    
                    # Show data table
                    checkboxInput(inputId = "show_data",
                                  label = "Display data table",
                                  value = TRUE),
                                  h5("This section allows the table in Data panel to be displayed or hiden
                                     based on user preference"),
                    br(),
                    br(),
          
                  ),
                  
                  # Output:
                  mainPanel(
                    
                    tabsetPanel(id = "tabspanel", type = "tabs",
                                tabPanel(title = "Base 1", 
                                         br(),
                                         h1("Add your preference")),
                                
                                tabPanel(title = "Base 2", 
                                         
                                         br(),
                                         h1("Add your preference")),
                                
                                tabPanel(title = "Base 3", 
                                         
                                         br(),
                                         h1("Add your preference")),
                                
                                tabPanel(title = "Data", 
                                         br(),
                                         DT::dataTableOutput(outputId = "testTable"),
                                         h1("Insert table"))
                    )
                  )
                )
)