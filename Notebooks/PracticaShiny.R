library(shiny)
library(HistData)
library(maps)
library(mapproj)

data(Galton)

ui <- fluidPage(
  titlePanel("Adivina la media"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("mu", "Adivina la media de la altura de los padres",
        value = 70, min = 62, max = 74, step = 0.05,
      ),
      img(src = "logo_ITAM.png", height = 23, width = 12)
    ),
    mainPanel(
      plotOutput("nvoHistog")
    )
  )
)

server <- function(input, output) {
  output$nvoHistog <- renderPlot({
    hist(Galton$parent,
      xlab = "Altura padres",
      ylab = "Frecuencia",
      col = "lightblue", main = "Histograma"
    )
    mu <- input$mu
    lines(c(mu, mu), c(0, 200), col = "red", lwd = 5)
    mse <- mean((Galton$parent - mu)^2)
    text(65, 180, paste("mu = ", mu))
    text(65, 170, paste("MSE = ", round(mse, 2)))
  })
}

shinyApp(ui, server)

condados <- readRDS("data/counties.rds")
head(condados,6)


#Mas preguntas de la practica

source("helpers.R")
percent_map(condados$white, "darkgreen", "% White")

#Porcentaje de personas negras en azul
percent_map(condados$black, "blue", "% Black")


#Añadiendo codigo a la app

# User interface ----
ui <- fluidPage(
  titlePanel("Visualiza Censo USA"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Crea mapas demográficos con información del censo de EUA en 2010."),
      
      selectInput("var",
                  label = "Escoja qué variable desea desplegar",
                  choices = c("Porcentaje blancos", "Porcentaje negros",
                              "Porcentaje hispanos", "Porcentaje asiáticos"),
                  selected = "Porcentaje blancos"),
      
      sliderInput("rango",
                  label = "Rango de interés:",
                  min = 0, max = 100, value = c(0, 100))
    ),
    
    mainPanel(plotOutput("map"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var,
                   "Porcentaje blancos" = condados$white,
                   "Porcentaje negros" = condados$black,
                   "Porcentaje hispanos" = condados$hispanic,
                   "Porcentaje asiáticos" = condados$asian)
    
percent_map(var = data, color = "yellow", legend.title = "prueba")
  })
}
shinyApp(ui, server)

















