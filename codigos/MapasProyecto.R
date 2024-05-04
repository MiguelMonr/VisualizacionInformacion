library(ggplot2)
library(maps)
library(sf)
library(sp)
library(leaflet)
library(dplyr)

df1 <- read.csv("v2Abril.csv")
#df2 <- read.csv("df_combined.csv")
head(df1)

uspolig <- st_read("us-states.json")


# Uniendo los datos basados en las abreviaturas de los estados
uspolig <- uspolig %>%
  left_join(df1, by = c("id" = "State.Abbr."))

head(uspolig, 4)

# Creando un mapa con los polígonos coloreados por, por ejemplo, la tasa de impuestos
mp1 <- leaflet(uspolig) %>%
  addTiles() %>%
  addPolygons(fillColor = ~colorNumeric("YlOrRd", uspolig$State.Sales.Tax.Rate, n = 5)(State.Sales.Tax.Rate),
              fillOpacity = 0.8, 
              weight = 2, 
              color = "white",
              dashArray = "3") %>%
  addMarkers(
    lng = ~longitude,  # Usar columna 'longitude' para la longitud de los marcadores
    lat = ~latitude,   # Usar columna 'latitude' para la latitud de los marcadores
    popup = paste0(
      "<strong>Nombre: </strong>", uspolig$name, "<br>",
      "<strong>Año: </strong>", uspolig$Year, "<br>",
      "<strong>Región: </strong>", uspolig$Region, "<br>"
    )
  ) %>%setView(lng = -97.31, lat = 37.69, zoom = 4)%>% 
  addLegend(
    position = "bottomright",  
    pal = colorNumeric("YlOrRd", uspolig$State.Sales.Tax.Rate),  
    values = uspolig$State.Sales.Tax.Rate,  
    title = "Impuestos en los ultimos 10 años"  
  )

mp1


#Para Soda este funciona con nuevo df
mp2 <- leaflet(uspolig) %>%
  addTiles() %>%
  addPolygons(fillColor = ~colorNumeric("YlOrRd", uspolig$Soda)(uspolig$Soda),
              fillOpacity = 0.8, 
              weight = 2, 
              color = "white",
              dashArray = "3") %>%
  setView(lng = -97.31, lat = 37.69, zoom = 4) %>% 
  
  addLegend(
    position = "bottomright",  
    pal = colorNumeric("YlOrRd", uspolig$Soda),  
    values = uspolig$Soda,  
    title = "Impuestos de Soda en los ultimos 10 años"  
  )

mp2

Ice.Cream <- uspolig$Ice.Cream
head(Ice.Cream)
#Para chisp (agains)
mp2 <- leaflet(uspolig) %>%
  addTiles() %>%
  addPolygons(fillColor = ~colorNumeric("YlOrRd", Ice.Cream)(Ice.Cream),
              fillOpacity = 0.8, 
              weight = 2, 
              color = "white",
              dashArray = "3") %>%
  setView(lng = -97.31, lat = 37.69, zoom = 4) %>% 
  
  addLegend(
    position = "bottomright",  
    pal = colorNumeric("YlOrRd", Ice.Cream),  
    values = Ice.Cream,  
    title = "Impuestos de chips en los ultimos 10 años"  
  )

mp2


#para chips and pretzels
mp3 <- leaflet(uspolig) %>%
  addTiles() %>%
  addPolygons(fillColor = ~colorNumeric("YlOrRd", domain= uspolig$Chips..Pretzels)(Chips..Pretzels ),
              fillOpacity = 0.8, 
              weight = 2, 
              color = "white",
              dashArray = "3") %>%
  setView(lng = -97.31, lat = 37.69, zoom = 4)%>% 
  
  addLegend(
    position = "bottomright",  
    pal = colorNumeric("YlOrRd", uspolig$Chips..Pretzels),  
    values = uspolig$Chips..Pretzels,  
    title = "Impuestos de frituras en los ultimos 10 años"  
  )

mp3

#Para helados 
mp5 <- leaflet(uspolig) %>%
  addTiles() %>%
  addPolygons(
    fillColor = ~colorNumeric("YlOrRd", domain = uspolig$Ice.Cream)(Ice.Cream),
    fillOpacity = 0.8,
    weight = 2,
    color = "white",
    dashArray = "3"
  ) %>%
  setView(lng = -97.31, lat = 37.69, zoom = 4)%>% 
  
  addLegend(
    position = "bottomright",  
    pal = colorNumeric("YlOrRd", uspolig$Ice.Cream),  
    values = uspolig$Ice.Cream,  
    title = "Impuestos de helados en los ultimos 10 años"  
  )

mp5

#Prueba interactividad: 


