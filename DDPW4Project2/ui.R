#
# This is the user-interface definition of a Shiny web application. 
#
library(shiny)
library(shinythemes)
library(datasets)
mydataset <- data(mtcars)
mycol <- names(mtcars)

ui <- fluidPage(
    # define the theme used for the app
    theme = shinythemes::shinytheme("slate"),
    # The title
    titlePanel("Introductory Analysis of the mtcars data set"),
    # Sidebar layout with input and output definitions
    sidebarLayout(
        # Sidebar panel for inputs ----
        sidebarPanel(
            # Input Y variable
            selectInput("yvar", "Select your Y variable", mycol),
            # Input X variable
            selectInput("xvar", "Select your X variable", names(mtcars))
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            # Tabs
            tabsetPanel(
                tabPanel("Data Table",
                         h4("Table"),
                         # returns the table view of the observations
                         tableOutput("table")
                ),
                tabPanel("Data set Details", 
                         # provide the data set and var descriptions
                         verbatimTextOutput("details")
                ),
                tabPanel("Some Statistics", 
                         # return the summary statistics of each var
                         verbatimTextOutput("dataSummary")
                ),
                
                tabPanel("Variables Summary", 
                         # returns summary statistics
                         "Variable Y statistical summary",
                         verbatimTextOutput("ySummary"),
                         "Variable X statistical summary",
                         verbatimTextOutput("xSummary")
                ),
                
                tabPanel("Histograms",
                         # plot the histograms for var X and Y
                         plotOutput("hist")),
                
                tabPanel("Scatter Plot",
                         # Plot the scatter plot of X vs Y
                         plotOutput("scatter"))
            )
        )
    )
)