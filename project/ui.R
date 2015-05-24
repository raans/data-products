library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Manual transmission prediction"),
  
  sidebarLayout(
    sidebarPanel(
      h5("How does horse power and weight predict manual transmission?"),
      hr(),
      numericInput("hpower", 
                   "Horse power:", 
                   value = 120,
                   min = 0,
                   max = 500),

      br(),
      
      sliderInput("weight", 
                  "Weight of car [lb]:", 
                  value = 2800,
                  min = 1000,
                  max = 6000,
                  step = 50),
      br(),
      textOutput("info"),
      hr(),
      htmlOutput("pred")
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Plot", plotOutput("plot")), 
                  tabPanel("Model", verbatimTextOutput("model")),
                  tabPanel("Help", htmlOutput("help"))
      )
    )
  )
))