# R-shiny-Introduction

# In this GitHub I will give an introduction to how R shiny works and how it can be used as an interactive tool for data visualisation in human movement science.
# In this readme file I will step-by-step explain how elements of R shiny work and will refer to the different scripts that can be found in the GitHub. The scripts will work as examples for the element I'm explaining and can be downloaded en run in RStudio. You can download Rstudio through this link: https://posit.co/download/rstudio-desktop/ 

# Let's start with the basics. 
# When making a shiny script, your script will always have 3 elements: the User interface (UI), the server and the part that combines the UI and server to make a shiny app. The UI is basically how the app will look like, what input the viewer can select and what output will be returned. The server is the brains behind the shiny app where the calculations are made and the right output is produced. 

# The UI can have lots of elements like titles, taps and panels. A theme can also be used to make the app look better by adding different colours. But for now, we will stick to the basics first. An important part of the UI code is selecting which type of input and output u want. There are different input options like a slider, a select function or a text or numeric input. Outputs consist for instance of plots or tables. An overview of all the input and output options can be found at this link: https://github.com/rstudio/cheatsheets/blob/main/shiny.pdf 
# In the server the input values can be used to set variables and make calculations. Here u also select what variables u want to use in the output.
# To get an understanding how a basic app looks like, let's move to the first app in this GitHub, called app1_BMI. This is an app that calculates the BMI score based on the height and weight u put in. In the script, every function has an explanation that will tell u what it does. Download the script and run it in Rstudio to play around with it and get an understanding of how all elements of the script work.

# In aap1_BMI there was a function called reactive. Reactive coding is a very important part of Rshiny. Most traditional scrips in R, Matlab or Python run from top to bottom. In Rshiny this is not the case! Shiny works the other way around. It looks at what variables it needs to generate the output and then runs the part of the code that calculates this variable. But Rshiny is very lazy! If it has already calculated all the variables, it will not rerun the code but just use the variables it already has. An example of this can be explained by looking at app1_BMI. We put in our weight and height and the app calculates the BMI. If we would then change the variables of weight and height, it would need to rerun the code to calculate the new BMI. But Rshiny already has a variable BMI so it is lazy and will not rerun the rode and just display the old calculated BMI score. This is a problem because this means the app will only calculate the first BMI score and then stop working. This is why we need the reactive function. If we place the code that calculates the BMI score in a reactive function, it means that the code reacts to any changes in the function. So if the input variables weight of height changes, the BMI will be recalculated. 
# U might ask yourselves, why Rshiny works this way. And the biggest reason for this makes more sense if we look at big and complicated apps. If apps are very big and complicated with a lot of variables that need to be calculated, it would take a lot of time to rerun the full script every time an input variable is changed. The app would then work very slowly and sometimes take multiple minutes to run. So to make it fast and interactive, the reactive work style of Rshiny is important. 
# We will now move on to a more complicated app that will make a scatter plot where u can select what variables to put on the x and y-axis. It will also let you choose what grouping variable to use to color the points.  The script that makes this plot is called app2_plot and can be downloaded from this GitHub. The app uses a dataframe that is available for everyone in R and is called mtcars. This dataframe looks at different aspects of different cars, like horsepower weight and engine type. The dataframe will be adjusted a bit at the top of the script so that we can use it as an example. A problem with using an input value to select a variable from a dataframe in a plot is that it can’t work directly. Download the app, run it and look at the code and try to see what extra function is needed to use input values to select dataframe variables. 
# As you may have seen in app2_plot, we use the symbol function to change the input value to a symbol and then remove the symbol with !! to select the right variable from the data frame. Before continuing, let’s do an exercise! Change the code in the app2_plot so that xvar1, yvar1 and groupvar variables are not made, but the input goes directly into the ggplot. Next to this, try to add extra input values that set the alpha and size of the points in the scatterplot. Tip, check geom_point help function to see all the options for the geom_point! The correct answer will be in app3_plot2.
# Until now we only made a plot that is not interactive. We will now add a function that lets u interact with the plot. There are four options for interaction: clicking on a point, double-clicking on a point, hovering over a point, and selecting multiple points using brush. In our case, we are going to use the brush function to select points in our scatter plot. This way we can get information about the outliers in our data. We want to select the points with the brush and then get a table giving information about these points. For this, we need to put a table output in the UI and server that uses the brush input as the output of the table. Before looking at the solution, try to code this yourself using the app3_plot2 scripts. The solution can be found in app4_plot_interactive.
# Now we have an interactive plot where we can explore our data and check the info of points in the plot by selecting them. But this app, and the ones we made before this, look very basic. It is not very appealing to use this looking app in a presentation. But we can easily change this.  Rshiny has a built-in themes function. Whit this we can change the visual theme of the app. To do this, we need to add 2 lines to the script. One at the start of the script to add the package that uses the themes: library(shinythemes). This line can be added to under the other library lines of the script. The second line will be added in the first line where the ui starts. Directly after fluidPage( we add theme = shinytheme(“cerulean”), This leads to the first line of the ui looking like: ui <- fluidPage(theme = shinytheme(“cerulean”), In this case, the theme that is chosen is the cerulean theme. But there are many different themes that u can use. The other theme names are: cosmo, cyborg, darkly, flatly, journal, lumen, paper, readable, sandstone, simplex, slate and spacelab. Try to add a theme to the app4_plot_interactive and use the different themes to see which one u like best!
