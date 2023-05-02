
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
            actionButton("submitbutton", 
                         "GO!", 
                         class = "btn btn-primary")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  output$distPlot <- renderPlot({
    if (input$submitbutton>0) {
      xvar1 <- sym(input$xvar) #We have to change the input value into a symbol with the sym function to remove the input characteristic of the value
      yvar1 <- sym(input$yvar)
      groupvar <- sym(input$group)
      isolate(mtcars2 %>%
        ggplot(aes(x = !! xvar1, y = !! yvar1, color = !! groupvar)) +   # Using !! removes the symbol characteristic from the variables, this way Rshiny can link the input name of the variable with the column name of the dataframe
        geom_point(size = 6))
    }})
}

# Run the application 
shinyApp(ui = ui, server = server)
