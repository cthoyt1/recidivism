require(shiny)
require(ggplot2)
require(viridisLite)
require(dplyr)
require(readr)

# setwd('~/Learning/STAT-656/recidivism/shinyapp')
shiny_data <- read_csv('pca_data.csv', col_names=TRUE)

ui <- fluidPage(
  headerPanel("STAT-656 Recidivism Project: Aligning Principle Components to Features"),
  
  sidebarPanel(
    selectInput("feature", "Feature:",
    c("Recidivated (Supervisor)" = "Ytrain",
      "Sex" = "sexFemale",
      "Age" = "age",
      "African American" = "raceAfrican.American",
      "Asian" = "raceAsian",
      "Caucasian" = "raceCaucasian",
      "Hispanic" = "raceHispanic",
      "Other Race" = "raceOther",
      "Count of Juvenile Felonies" = "juv_fel_count",
      "Count of Juvenile Misdemeanors" = "juv_misd_count",
      "Count of Other Juvenile Offenses" = "juv_other_count",
      "Count of Priors" = "priors_count",
      "Degree of Charge" = "c_charge_degreeM",
      "Log of Age" = "log.age.",
      "Log of Count of Juvenile Felonies" = "log.juv_fel_count.",
      "Log of Count of Juvenile Misdemeanors" = "log.juv_misd_count.",
      "Log of Count of Other Juvenile Offenses" = "log.juv_other_count.",
      "Log of Count of Priors" = "log.priors_count."
      )
  )
),

mainPanel(
  plotOutput("pca_plot")
)
)

server <- function(input, output, session) {
  
  color_choice <- reactive({
     shiny_data %>% select(input$feature) %>% unlist(.)
  })

  output$pca_plot <- renderPlot({
    ggplot(data = shiny_data, aes(x=PC1, y = PC2)) +
      geom_point(aes(color = color_choice()), alpha = 0.33) +
      scale_colour_viridis_b()
  }
  )
  
}

shinyApp(ui, server)