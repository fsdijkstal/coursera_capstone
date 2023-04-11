

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Text Prediction App"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
          textInput('text', label = ('Please enter a text string and likely next words will be displayed below'), value = 'Good day'),
          
          dataTableOutput('table')
          
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))
