library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  dsmall <- as.data.frame(diamonds[sample(nrow(diamonds), 1000),])
  dsmall$caratmd <- ifelse(dsmall$carat - 0.7 > 0, dsmall$carat -0.7, 0)


  model1 <- lm(price ~ carat, data = dsmall)
  model2 <- lm(price ~ caratmd + carat, data = dsmall)

  model1pred <- reactive({
    caratInput <- input$sliderCarat
    predict(model1, newdata = data.frame(carat = caratInput))
  })

  model2pred <- reactive({
    caratInput <- input$sliderCarat
    predict(model2, newdata = data.frame(carat = caratInput, caratmd = ifelse(caratInput - 0.7 > 0, caratInput -0.7, 0)))
  })
                        
                         
  output$plot1 <- renderPlot({
    
   caratInput <- input$sliderCarat
  
  plot(dsmall$carat, dsmall$price,  xlab = "carat", ylab = "price", 
       bty = "n", pch = 16,
         xlim = c(0, 5), ylim = c(0, 49000))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      abline(model2, col = "blue", lwd = 2)
    }


    legend(0,45000, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
           col = c("red", "blue"))
    points(caratInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(caratInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })

    output$pred1 <- renderText({
       model1pred()
    })
    output$pred2 <- renderText({
       model2pred()
     })
})    