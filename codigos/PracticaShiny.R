library(shiny)
library(HistData)
data(Galton)

ui <- fluidPage(
  titlePanel("Adivina la media"), img(src = "imagen.jpg", height = xx, width = yy),
  sidebarLayout(
    sidebarPanel(
      sliderInput('mu', 'Adivina la media de la altura de los padres',
                  value = 70, min = 62, max = 74, step = 0.05,)
    ),
    mainPanel(
      plotOutput('nvoHistog')
    )
  )
)

server <-function(input, output) {
  output$nvoHistog <- renderPlot({
    hist(Galton$parent, xlab='Altura padres',
         ylab="Frecuencia",
         col='lightblue', main='Histograma')
    mu <- input$mu
    lines(c(mu, mu), c(0, 200),col="red",lwd=5)
    mse <- mean((Galton$parent - mu)^2)
    text(65, 180, paste("mu = ", mu))
    text(65, 170, paste("MSE = ", round(mse, 2)))
  })
}

shinyApp(ui, server)
#Añadiendo imagen






