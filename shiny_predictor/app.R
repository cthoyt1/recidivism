library(shiny)

h1("Recidivism Prediction App")


ui <- fluidPage(
  ##App title
  titlePanel("Recidivism Prediction App"),
  
  sidebarLayout(position = "right",
                
                sidebarPanel(selectInput("sex", label = "Sex", choices = c("Male","Female")),
                             selectInput("race", label = "Race", choices = c("Other","African-American","Caucasian","Hispanic", "Native American","Asian")),
                             selectInput("age", label = "Age", choices = c(19:100)),
                             selectInput("charge_degree", label = "Charge Degree", choices = c("M","F")),
                             selectInput("juv_fel_count", label = "Juvenile Felony Count", choices = c(0:100)),
                             selectInput("juv_misd_count", label = "Juvenile Misdemeanour Count", choices = c(0:100)),
                             selectInput("juv_other_count", label = "Juvenile Other Count", choices = c(0:100)),
                             selectInput("priors_count", label = "Priors Count", choices = c(0:100)),actionButton("action", label = "GO")),
                
                mainPanel(tableOutput("finalResult"), position = "right")
                
                
  ))


# Define server logic ----
server <- function(input, output) {
  
  output$finalResult <- renderTable(rownames = TRUE,{ 
    isolate({  
      T.gender <- input$sex
      T.age <- as.numeric(input$age)
      T.race <- input$race
      T.chargeDegree <- input$charge_degree
      T.juvFelCount <- as.numeric(input$juv_fel_count)
      T.juvMisdCount <- as.numeric(input$juv_misd_count)
      T.juvOtherCount <- as.numeric(input$juv_other_count)
      T.priorCount <- as.numeric(input$priors_count)
      
      
    })
    if(input$action == 0) {return()}
    
    
    RecidPredict(T.gender,T.race,T.chargeDegree,T.age,T.juvFelCount,T.juvMisdCount,T.juvOtherCount,T.priorCount)
    
  })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)