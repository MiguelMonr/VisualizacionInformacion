library(shiny)
library(leaflet)

ui <- fluidPage(
  leafletOutput("miMapa"),
  p(),
  actionButton("recalc", "Nuevos puntos")
)

server <- function(input, output) {
  puntos <- eventReactive(input$recalc,
    {
      cbind(rnorm(40) * 2 - 99.12766, rnorm(40) + 19.42847) # Aqui indicamos las coordenadas de MX
    },
    ignoreNULL = FALSE
  )

  output$miMapa <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(data = puntos())
  })
}

shinyApp(ui, server)


library(shiny)
library(leaflet)

# Interfaz de usuario
# El primer argumento de column es el ancho de la columna
# Despliega mapa y gráfica
ui <- fluidPage(
  br(),
  column(8, leafletOutput("miMapa", height = "600px")),
  column(4, plotOutput("grafica", height = "300px")),
  br()
)

server <- function(input, output) {
  # Dataframe con dos lugares
  data <- data.frame(x = c(-99.2, -100), y = c(19.34, 25), id = c("Lugar1", "Lugar2"))

  # Va a almacenar la posición del marcador donde se hizo clic
  data_of_click <- reactiveValues(clickedMarker = NULL)

  # Leaflet con dos marcadores, posicionado en México
  output$miMapa <- renderLeaflet({
    leaflet() %>%
      setView(lng = -99.2, lat = 19.34, zoom = 4) %>%
      addTiles(options = providerTileOptions(noWrap = TRUE)) %>%
      addCircleMarkers(data = data, ~x, ~y, layerId = ~id, popup = ~id, radius = 8, color = "black", fillColor = "red", stroke = TRUE, fillOpacity = 0.8)
  })

  # Almacena el clic
  # Se trata de variables internas
  observeEvent(input$miMapa_marker_click, {
    data_of_click$clickedMarker <- input$miMapa_marker_click
  })

  # Haz un scatterplot o un barplot dependiendo del punto seleccionado
  output$grafica <- renderPlot({
    my_place <- data_of_click$clickedMarker$id
    if (is.null(my_place)) {
      my_place <- "Lugar1"
    }
    if (my_place == "Lugar1") {
      plot(rnorm(1000), col = rgb(0.9, 0.4, 0.1, 0.3), cex = 3, pch = 20)
    } else {
      barplot(rnorm(10), col = rgb(0.1, 0.4, 0.9, 0.3))
    }
  })
}

shinyApp(ui = ui, server = server)

# Los marker click son eventos que ocurren cuando el usuario hace clic en un marcador
# Los reactive values son objetos espaciales utilizados para almacenar y gestionar markerclivks


# Nuevo mapa

ui <- fluidPage(
  br(),
  column(8, leafletOutput("miMapa", height = "600px")),
  column(4, plotOutput("grafica", height = "300px")),
  br()
)

server <- function(input, output) {
  # Dataframe con dos lugares
  data <- data.frame(x = c(-110.3126, -89.6243), y = c(24.1426, 20.9676), id = c("Lugar1", "Lugar2"))

  # Va a almacenar la posición del marcador donde se hizo clic
  data_of_click <- reactiveValues(clickedMarker = NULL)

  # Leaflet con dos marcadores, posicionado en México
  output$miMapa <- renderLeaflet({
    leaflet() %>%
      setView(lng = -99.2, lat = 19.34, zoom = 4) %>%
      addTiles(options = providerTileOptions(noWrap = TRUE)) %>%
      addCircleMarkers(data = data, ~x, ~y, layerId = ~id, popup = ~id, radius = 2, color = "black", fillColor = "red", stroke = TRUE, fillOpacity = 0.8)
  })

  # Almacena el clic
  # Se trata de variables internas
  observeEvent(input$miMapa_marker_click, {
    data_of_click$clickedMarker <- input$miMapa_marker_click
  })

  # Haz un scatterplot o un barplot dependiendo del punto seleccionado
  output$grafica <- renderPlot({
    my_place <- data_of_click$clickedMarker$id
    if (is.null(my_place)) {
      my_place <- "Lugar1"
    }
    if (my_place == "Lugar1") {
      plot(rnorm(1000), col = rgb(0.9, 0.4, 0.1, 0.3), cex = 3, pch = 20)
    } else {
      barplot(rnorm(10), col = rgb(0.1, 0.4, 0.9, 0.3))
    }
  })
}

shinyApp(ui = ui, server = server)

library(ggplot2)

df1 <- read.csv("estadosMx.csv")
mxpolig <- st_read("MapaMexico.geojson")
palPob <- colorNumeric("Blues", domain = df1$POB)
palDens <- colorBin("Greens", domain = df1$DENS, 6, pretty = F)
bins <- c(0, 20, 45, 79, 150, 390, 800, 7000)
palDens <- colorBin("Greens", domain = df1$DENS, bins = bins, pretty = F)
# Plantilla
ui <- fluidPage(
  titlePanel("Mapas"),
  sidebarLayout(
    sidebarPanel(
      helpText("Crea mapas de población y densidad."),
      selectInput("var",
        label = "Escoja qué variable desea desplegar",
        choices = c("Por densidad", "Por población"),
        selected = "Por población"
      ),
    ),
    mainPanel( #Aqui se describen las variables del inpunt
      column(5, (leafletOutput("mapaCarla", height = "600px"))),
      # Aquí también iría outputplot

      column(5, (plotOutput("grafico")))
    )
  )
)

# Server logic ----

server <- function(input, output) {
  output$mapaCarla <- renderLeaflet({ #Mostramos el mapa por default
    if (input$var == "Por población") {
      leaflet(mxpolig) %>%
        addTiles() %>%
        addPolygons(
          group = "Por Población",
          stroke = F,
          smoothFactor = 0.2,
          opacity = 1.0,
          fillOpacity = 0.5,
          fillColor = ~ palPob(df1$POB),
          highlightOptions = highlightOptions(
            color = "white",
            weight = 2,
            bringToFront = T
          ),
          label = df1$NOM_ENT,
          labelOptions = labelOptions(direction = "auto")
        ) %>%
        addLegend(
          group = "Por Población", position = "bottomleft", pal = palPob,
          values = ~ df1$POB, title = "Población"
        )
    } else {
      leaflet(mxpolig) %>%
        addTiles() %>%
        addPolygons(
          stroke = F,
          smoothFactor = 0.2,
          opacity = 1.0,
          fillOpacity = 0.5,
          fillColor = ~ palDens(df1$DENS),
          highlightOptions = highlightOptions(
            color = "white",
            weight = 2,
            bringToFront = T
          ),
          label = df1$NOM_ENT,
          labelOptions = labelOptions(direction = "auto")
        ) %>%
        addLegend(position = "bottomleft", pal = palDens, values = ~ df1$POB, title = "Densidad")
    }
  })
  # Gráfico dependiendo de los botones
  output$grafico <- renderPlot({ #!El grafico para los botones 
    if (input$var == "Por población") {
      ggplot(df1, aes(x = NOM_ENT, y = POB)) +
        geom_bar(stat = "identity", fill = "brown") +
        coord_flip() + # Hace que la gráfica sea horizontal
        labs(x = "Población", y = "Estado", title = "Población por Estado (en millones)") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    } else {
      hist(df1$DENS,
        breaks = 50, # Puedes ajustar este número para cambiar el número de barras
        main = "Distribución de densidad de población",
        xlab = "Densidad",
        ylab = "Frecuencia",
        col = "lightblue"
      )
    }
  })
}
shinyApp(ui = ui, server = server)
