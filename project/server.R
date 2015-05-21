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
    sprintf("For a car with a <em>%d hp</em> engine and <em>%.0f lbs</em> weight, the probability of it being fitted with a manual transmission is about <b>%.2f%%</b>.", input$hpower, input$weight, pred()*100)
  })
  
  output$plot <- renderPlot({
    p <- ggplot(mtcars, aes(x=hp, y=wt*1000))
    p <- p + geom_point()
    p <- p + labs(title="Horse power vs. Weight", x="Horse power", y="Weight [lb]")
    p <- p + geom_point(data=df(), aes(x=hp, y=wt*1000), color="red", size=6)
    p <- p + geom_line(data=logit_wt(), aes(x=hp, y=wt*1000), color="blue")
    print(p)
  })
  
  output$summary <- renderPrint(summary(mtcars))
  output$sig <- renderPrint(summary(model()))

  output$help <- renderText(
"<p>Dataset: mtcars (R standard dataset)</p>
<p>Prediction model used: Generalized linear model with a binomial family (estimated logistic regression)</p>
<p>Legend/abbreviations:</p>
mpg:	Miles/(US) gallon</br>
cyl:	Number of cylinders</br>
disp:	Displacement (cu.in.)</br>
hp:	Gross horsepower</br>
drat:	Rear axle ratio</br>
wt:	Weight (lb/1000)</br>
qsec:	1/4 mile time</br>
vs:	V/S</br>
am:	Transmission (0 = automatic, 1 = manual)</br>
gear:	Number of forward gears</br>
carb:	Number of carburetors")

})
