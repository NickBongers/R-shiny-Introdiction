
library(shiny)

####################################
# User Interface                   #
# This is the part that is visible #
# for the user of the app          #
####################################

ui <- fluidPage(navbarPage("BMI Calculator:",      #This line starts the ui part with a webpage with the function fluidpage. the navbarPage is a bar on the top of the page and you can add a title like "BMI calculator"
                           
                           tabPanel("Home",        #this starts a tab on the navbar where we work is, you can have multiple tabs.
                                    # Input values
                                    sidebarPanel(  #this starts an area where the user can interact with and give input values
                                      h3("Input parameters"),  #this starts a title, the 3 is for the size of the title
                                      sliderInput("height",   #Our first widget we use is a slider where the user can give input values. The first name will be the variable name that is saved in R
                                                  label = "Height", #the title above the slider
                                                  value = 175,      #the starting value of the slider
                                                  min = 40,         #the range of the slider
                                                  max = 250),
                                      sliderInput("weight", 
                                                  label = "Weight", 
                                                  value = 70, 
                                                  min = 20, 
                                                  max = 100),
                                      
                                      actionButton("submitbutton",  #setting a submit button to start the calculater
                                                   "Submit", 
                                                   class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(      #This starts an area where the results will be shown
                                      tableOutput('tabledata') # Results table where the calculated bmi will be shown
                                    ) # mainPanel()
                                    
                           ), #tabPanel(), Home
                           
                ) # navbarPage()
) # fluidPage()


####################################
# Server                           #
####################################
server <- function(input, output, session) {    #Start of the server part always starts with a function with input and output, session will be more import when you make a live app but for now we can just add it.
  
  # Input Data
  datasetInput <- reactive({  #making a variable were the calculated bmi will be saved, by making it reactive, it will react and recalculate whenever one of the varaibles changes
    
    bmi <- input$weight/( (input$height/100) * (input$height/100) )  #bmi is calculated by the input weight and height
    bmi <- data.frame(bmi)    #make a dataframe of the calculated bmi
    names(bmi) <- "BMI"       #add a column name to the data frame
    bmi                       #this saves the calculated bmi to the variable datasetInput
    
  })

  # Prediction results table
  output$tabledata <- renderTable({   #make the output table with the calculated bmi in it.
    if (input$submitbutton>0) {       #this makes sure the bmi will be calculated when the submitbutton is pressed
      isolate(datasetInput())         #the isolate function make sure the bmi will only be showed when the submit button is pressed and not when the input variables change. make sure to add () after the variable!
    } 
  })
  
}


####################################
# Create Shiny App                 #
####################################
shinyApp(ui = ui, server = server)   #Very important line! this adds the ui and server together to make a shiny app.
