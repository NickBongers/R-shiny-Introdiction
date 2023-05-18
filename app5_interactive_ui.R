
# Load in the needed packages
library(shiny)
library(tidyverse)
library(shinythemes)

# Load and modify the data set so we can use it
data(mtcars)
mtcars2 <- mtcars
mtcars2$vs <- factor(mtcars2$vs, labels = c("V-shape", "Straight")) #label the 2 factors of this variable
mtcars2$am <- factor(mtcars2$am, labels = c("automatic", "manual")) #label the 2 factors of this variable

choice1 <- c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "gear", "carb") #All the names of the continu variables
choice2 <- c("vs", "am") #all the names of the group variables

parameter_tabs <- tabsetPanel( #make a hidden variable with a tabsetPanel that shows different input options based on the selection of what type of plot
  id = "params",               #id name that is used in the server
  type = "hidden",             #hidden type so that it only becomes visible when the correct option in chosen
  tabPanel("scatter",          #first option is scatter. If scatter is chosen, the following input options will become visible.
           selectInput("var1", "Variable x-axis:", choice1),
           selectInput("var2", "Variable y-axis:", choice1),
           selectInput("groupvar1", "Split data into groups:", choice2),
           sliderInput("alpha1", "Transparity:", value = 1, min = 0.001, max = 1),
           sliderInput("size1", "Size:", value = 1, min = 0.5, max = 5),
           actionButton("submitbutton", 
                        "GO!", 
                        class = "btn btn-primary")
  ),
  tabPanel("box",              #if box is chosen, the following input options will become visible
           selectInput("var3", "Variable x-axis:", choice2),
           selectInput("var4", "Varaible y-axis:", choice1),
           actionButton("submitbutton2", 
                        "GO!", 
                        class = "btn btn-primary")
  )
)

output_tabs <- tabsetPanel(    #the same will be done for the output. Where the output is dependent to the chosen plot option
  id = "outputs",
  type = "hidden",
  tabPanel("scatter",
           plotOutput("distPlot", brush = "plot_brush"),
           tableOutput("data")
           ),
  tabPanel("box",
           plotOutput("plot2"))
)

# Start of the UI 
ui <- fluidPage(theme = shinytheme("flatly"),   #add a theme to the app

    # Application title
    titlePanel("mtcars data visualization"),

    # Sidebar with select inputs to select what variables to use in the plot 
    sidebarLayout(
        sidebarPanel(
                    h3("Input parameters"),
                    selectInput("geom", "Select type of plot:", choices = c("scatter", "box")),  #option to chose what plot to use
                    parameter_tabs    #this variable had the different input options that is depentend on what type of plot is selected
        ),

        # Show a plot of the generated distribution
        mainPanel(
           output_tabs   #the variable that has the hidden outputs
        )
    )
)

# Define server
server <- function(input, output, session) {

  observeEvent(input$geom, {   #this function watches input$geom and will run every time this input changes
    updateTabsetPanel(inputId = "params", selected = input$geom) #this line will update the variable with the hidden inputs, based on the input$geom value
  })
  
  observeEvent(input$geom, {    #the same is done here but for the output variables
    updateTabsetPanel(inputId = "outputs", selected = input$geom)
  })
  
  #make the scatter plot
  observeEvent(input$submitbutton, {   #we now use the same obesrveEvent option for the submit button in stead of how we did it last time. It works the same way
    output$distPlot <- renderPlot({
      isolate(mtcars2 %>%
                ggplot(aes(x = !! sym(input$var1), y = !! sym(input$var2), color = !! sym(input$groupvar1))) +   # you can add !! and sym in the ggplot lines to make it shorter and simple
                geom_point(alpha = input$alpha1, size = input$size1) + theme_classic()) # alpha and size should be inside the geom_point
    })
  })
  
  #make the table output of the brush funciton
  output$data <- renderTable({
    brushedPoints(mtcars2, input$plot_brush)
  })
  
  #make the box plot
  observeEvent(input$submitbutton2, {
    output$plot2 <- renderPlot({
      isolate(mtcars2 %>%
                ggplot(aes(x = !! sym(input$var3), y = !! sym(input$var4))) +
                geom_boxplot() + theme_classic())
    }) 
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
