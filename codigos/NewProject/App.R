library(DT)
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title="Mi primer dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("iris", tabName = "iris", icon = icon("tree")),
      menuItem("mtcars", tabName = "cars", icon = icon("car"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("iris",
              box(plotOutput("hist_plot"),width=8),
              box(selectInput("funciones", "Funciones:",
                              c("Sepal.Width", "Petal.Length",
                                "Petal.Width")),width=4)
      ),
      tabItem("mtcars",
              box(plotOutput("hist_mtcars"),width=8),
              box(selectInput("funciones", "Funciones:",
                              c("mpg",
                                "Petal.Width")),width=4)      
      )
    )
  )
)


server <- function(input, output) {
  output$hist_plot=renderPlot({
    plot(iris$Sepal.Length,iris[[input$funciones]],
         xlab="Sepal.Length",ylab=c("Función ",input$funciones))
  })
  output$carstable <- renderDataTable(mtcars)
}
shinyApp(ui, server)