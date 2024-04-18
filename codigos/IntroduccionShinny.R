#Codigos para shinny 
library(shiny)
# Interfaz de usuario
ui <- fluidPage(
  '¡Hola Mundo!'
)
# Servidor
server <- function(input, output, session) {
}
shinyApp(ui, server)