library(shiny)
library(shinydashboard)
library(dplyr)
library(gg)

df <- read.csv("RegistrosQoS.csv")

head(df)

df$Tipo.de.red <- trimws(df$Tipo.de.red )

head(df)



ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)
server <- function(input, output) {
}
shinyApp(ui, server)

#Añadiendo más detalles
ui <- dashboardPage(
  dashboardHeader(title="Mi primer
dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(" Miguel"),
      menuItem("Arturo")
    )
  ),
  dashboardBody(
    box(plotOutput("correl_plot"),width=8)
  )
)
server <- function(input, output) {
  output$correl_plot=renderPlot({
    plot(iris$Sepal.Length,iris$Petal.Length)
  })
}

shinyApp(ui, server)


#Test

ui <- dashboardPage(
  dashboardHeader(title="Mi primer
dashboard"),
  dashboardSidebar(),
  dashboardBody(
    box(plotOutput("correl_plot"),width=8) #Aqui pones lo que quieres mostrar
  )
)
server <- function(input, output) {
  output$correl_plot=renderPlot({
    plot(iris$Sepal.Length,iris$Petal.Length) #Aqui la grafica que quieres mostrar
  })
}

shinyApp(ui, server)


#test2
ui <- dashboardPage(
  dashboardHeader(title="Mi primer dashboard"),
  dashboardSidebar(),
  dashboardBody(
    box(plotOutput("correl_plot"),width=8),
    box(
      selectInput("funciones", "Funciones:",
                  c("Sepal.Width", "Petal.Length",
                    "Petal.Width")),width=4 #Aqui pones el nombre de las opciones 
    )
  )
)


server <- function(input, output) {
  output$correl_plot=renderPlot({
    plot(iris$Sepal.Length,iris[[input$funciones]],
         xlab="Sepal.Length",ylab=c("Función ",input$funciones)) #En plot ponemos las graficas 
  })
}

shinyApp(ui, server)

#Mas pruebas
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
              box(plotOutput("correl_plot"),width=8),
              box(selectInput("funciones", "Funciones:",
                              c("Sepal.Width", "Petal.Length",
                                "Petal.Width")),width=4) 
      ),
      tabItem("cars",
              fluidPage(
                h1("Página para cars")
              )
      )
    )
  )
)


server <- function(input, output) {
  output$correl_plot=renderPlot({
    plot(iris$Sepal.Length,iris[[input$funciones]],
         xlab="Sepal.Length",ylab=c("Función ",input$funciones))
  })
}

shinyApp(ui, server)

#Con Histograma
ui <- dashboardPage(
  dashboardHeader(title="Grafica de Examen"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Histograma", tabName = "iris", icon = icon("tree")),
      menuItem("mtcars", tabName = "cars", icon = icon("car"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("iris",
              box(plotOutput("Histograma"),width=8),
              box(selectInput("funciones", "tipos de Red:",
                              c("EDGE", "EV-DO",
                                "HSPA+","LTE")),width=4) 
      ),
      tabItem("cars",
              fluidPage(
                h1("Página para cars")
              )
      )
    )
  )
)

server <- function(input, output) {
  output$Histograma=renderPlot({
      if(input$funciones=="EDGE"){
       
    
  })
})

shinyApp(ui, server)





