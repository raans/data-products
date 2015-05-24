library(shiny)
library(ggplot2)
data(mtcars)

shinyServer(function(input, output) {
  
  df <- reactive(
    {
      data.frame(hp=input$hpower, wt=input$weight/1000) # lb/1000
    })

  model <- reactive(
    {
      am.glm <- glm(data=mtcars, formula=am ~ hp + wt, family=binomial(link="logit")) # wt = lb/1000
    })
  
  pred <- reactive(
    {
      pred <- predict(model(), df(), type="response")
    })
    
  logit_wt <- reactive(
    {
      df.wt <- data.frame(hp=seq(from=0, to=500, length.out=500), wt=rep(input$weight, 500))
      logit_wt <- predict(model(), df.wt, type="response")
    })

  output$info <- renderText({ 
    sprintf("You have selected %d hp and %.0f lbs.", input$hpower, input$weight)
  })

  output$pred <- renderText({
    sprintf("The probability of the car being fitted with a manual transmission is about <b>%.2f%%</b>.", pred()*100)
  })
  
  output$plot <- renderPlot({
    p <- ggplot(mtcars, aes(x=hp, y=wt*1000))
    p <- p + geom_point()
    p <- p + labs(title="Horse power vs. Weight", x="Horse power", y="Weight [lb]")
    p <- p + geom_point(data=df(), aes(x=hp, y=wt*1000), color="red", size=6)
#    p <- p + geom_line(data=logit_wt(), aes(x=hp, y=wt*1000), color="blue")
    print(p)
  })
  
  output$model <- renderPrint(summary(model()))

  output$help <- renderText(
"<p>Dataset: mtcars (R standard dataset)</p>
<p>Prediction model used: Generalized linear model with a binomial family (estimated logistic regression)</p>
<p>
<ul>
<li>User input: horse power (hp) and weight (wt)</li>
<li>Output: A probabilty if a car fits the model on the left panel</li>
<li>Graph output: The point of the user's input (does not indicate the regression model's result)</li>
</ul>
</p>
")

})
