# R-shiny-Introdiction

# In this github I will give an introduction into how R shiny works and how it can be used as an interactive tool for data visualisation in human movement science.
# In this readme file I will step by step explain how elements of R shiny works and will refer to the different scripts that can be found in the github. The scipts will work as examples for the element I'm explaining and can be downloaden en run in RStudio.

# Let's start with the basics. 
# When making a shiny script, your script will always have 3 elements: the User interface (UI), the server and the part that combines the UI and server to make a shiny app. The UI is basically how the app will look like, what input the viewer can select and what output will be returned. The server is the brains behind the shiny app where the calculations are made and the right output is produced. 

# The UI can have lot's of elements like titles, taps and panels. A theme can also be used to make the app look better by adding different colors. But for now, we will stick to the basics first. An important part of the UI code is selecting which type of input and output u want to. There are different input options like a slider, a select function or a text or numeric input. Outputs consist for instance of plots or tables. An overview of all the input and output options can be found in this link: https://shiny.rstudio.com/images/shiny-cheatsheet.pdf 
