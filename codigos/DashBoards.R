library(shiny)
library(shinydashboard)

#UI
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) {
}

shinyApp(ui, server)