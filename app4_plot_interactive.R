
# Load in the needed packages
library(shiny)
library(tidyverse)

# Load and modify the data set so we can use it
data(mtcars)
mtcars2 <- mtcars
mtcars2$vs <- factor(mtcars2$vs, labels = c("V-shape", "Straight")) #label the 2 factors of this variable
mtcars2$am <- factor(mtcars2$am, labels = c("automatic", "manual")) #label the 2 factors of this variable

choice1 <- c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "gear", "carb") #All the names of the continu variables
choice2 <- c("vs", "am") #all the names of the group variables

# Start of the UI 
ui <- fluidPage(

    # Application title
    titlePanel("mtcars data visualization"),

    # Sidebar with select inputs to select what variables to use in the plot 
    sidebarLayout(
        sidebarPanel(
            selectInput("xvar", "X-axis variable:", choice1), #using choice1 gives the option to choose between all the variable names that are saved under the name choice1
            selectInput("yvar", "Y-axis variable:", choice1),
            selectInput("group", "Engine shape or engine type", choice2),
            sliderInput("alpha", "Transparity:", value = 1, min = 0.001, max = 1), #add alpha and size input values
            sliderInput("size", "Size:", value = 1, min = 0.5, max = 5),
            actionButton("submitbutton", 
                         "GO!", 
                         class = "btn btn-primary")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot", brush = "plot_brush"),
           tableOutput("data")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  output$distPlot <- renderPlot({
    if (input$submitbutton>0) {
      isolate(mtcars2 %>%
        ggplot(aes(x = !! sym(input$xvar), y = !! sym(input$yvar), color = !! sym(input$group))) +   # you can add !! and sym in the ggplot lines to make it shorter and simple
        geom_point(alpha = input$alpha, size = input$size)) # alpha and size should be inside the geom_point
    }})
  
  output$data <- renderTable({
    brushedPoints(mtcars2, input$plot_brush)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
