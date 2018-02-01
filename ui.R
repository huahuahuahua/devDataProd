library(shiny)
library(ggplot2)
data(diamonds)
#dsmall <- as.data.frame(diamonds[sample(nrow(diamonds), 500),])


shinyUI(fluidPage(
  titlePanel('Predict Diamond Price form Carat'),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCarat", "What is the carat of the diamond?" , 0, 5, value = 0.5, step = 0.1 ),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      submitButton("Submit")
    ),
    mainPanel(
      plotOutput("plot1"),
      h3('Predicted Diamond Price from Model 1:'),
      textOutput("pred1"),
      h3('Predicted Diamond Price  from Model 2:'),
      textOutput("pred2")
    )
  )
))