#
# This is the server logic of a Shiny web application. 
#
library(shiny)
library(datasets)
mydataset <- data(mtcars)

# Define server logic to display and download selected file ----
server <- function(input, output) {
    
    # let's make the chosen X and Y variables reactive to make them reusable later.
    selecty <- reactive({
        mtcars[, input$yvar]
    })
    
    selectx <- reactive({
        mtcars[, input$xvar]
    })
    
    # TAB: Data
    output$table <- renderTable({
        # Return first 10 rows of observations
        head(get(mydataset), 10)
    })
    
    # TAB: DETAILS
    output$details <- renderPrint(
        {
            dataset <- get(mydataset)
            # return the data set and its variables specifications
            str(dataset)
        }
    )

    # TAB: SOME STATISTICS
    output$dataSummary <- renderPrint(
        {
            # Calculate the summary statistics
            summary(get(mydataset))
        }
    )
    
    # TAB: VAR SUMMARY
    output$ySummary <- renderPrint(
        {
          # Calculate the statistical summary for y var
            summary(selecty())
        }
    )
    output$xSummary <- renderPrint(
        {
            # Calculate the statistical summary for X var
            summary(selectx())
        }
    )
    # TAB: HISTOGRAM
    output$hist <- renderPlot(
        {
            # plots the 2 histograms together on 2 rows
            par(mfrow = c(2, 1))
            hist(selecty(), main="Y Variable Histogram")
            hist(selectx(), main="X Variable Histogram")
        }
    )
    # TAB: SCATTER
    output$scatter <- renderPlot(
        {
            plot(selectx(), selecty(), xlab = "X Variable", ylab = "Y Variable", col = "red")
        })
}