library(shiny)
library(shinythemes)
library(readr)
library(DT)
library(tools)

#dataWIE <- read.csv("C:/Users/atjar/Downloads/THE.csv")
qs <- read.csv("C:/Users/atjar/Downloads/QS.csv")
the <- read.csv("C:/Users/atjar/Downloads/THE.csv")

# Define UI for application that plots features of University Ranking
ui <- fluidPage(theme = bslib::bs_theme(bootswatch = "superhero"),
                
                titlePanel("World University Ranking!", windowTitle = "University Ranking"),
                
                # Sidebar layout with a input and output definitions
                sidebarLayout(
                  
                  # Inputs
                  sidebarPanel(
                    
                    h3("Selection panel"),      
                    
                    #can use this if "year" variable is needed ya
                    # Select variable for year
                    #selectInput(inputId = "year", 
                     #           label = "Select a year: ",
                      #          choices = c("2017", "2018", "2019", "2020","2021","2022"), 
                       #         selected = "2018"),
                    
                   selectInput(inputId = "qsRanking", 
                                label = "Do you wish to view QS rankings? : ",
                                choices = qs$University,
                                selected = "QS Ranking"),
                    
                    selectInput(inputId = "theRanking", 
                                label = "Do you wish to view THE rankings? : ",
                                choices = the$name,
                                selected = "THE Ranking"),
                    
                    
                    hr(),
                    
                    
                    # Select variable for world rank
                    sliderInput(inputId = "worldRank", 
                                label = "World Rank: ",
                                min = 1, max = 50, 
                                value = "25"),
                    
                    
                    
                    #you dont have to display this if it doesn't suit your liking ya @sam
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

                    # to be edited based on preference
                    tabsetPanel(id = "tabspanel", type = "tabs",
                                tabPanel(title = "Base 1", 
                                         br(),
                                        # plotOutput(outputId = "tester"),
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

# Reference server to display ui(To be modified by sam)
server <- function(input, output, session) {
  
  # Display data table when box is checked
  observeEvent(input$show_data, {
    if(input$show_data){
      showTab(inputId = "tabspanel", target = "Data", select = TRUE)
    } else {
      hideTab(inputId = "tabspanel", target = "Data")
    }
  })
  
 # output$tester<-renderPlot({
    
  #})
    

  
  
}

# Create Shiny app object
shinyApp(ui = ui, server = server )
