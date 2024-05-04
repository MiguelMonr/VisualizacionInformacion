library(ggplot2)
library(maps)
library(sf)
library(sp)
library(leaflet)
library(dplyr)


df4 <- read.csv("df_combined.csv")
head(df4)




# Uniendo los datos basados en las abreviaturas de los estados


mp5 <- leaflet(df4) %>%
  addTiles() %>%
  addPolygons(
    fillColor = ~colorNumeric("YlOrRd", domain = df4$Ice.Cream)(Ice.Cream),
    fillOpacity = 0.8,
    weight = 2,
    color = "white",
    dashArray = "3",
    lng = ~longitude,
    lat = ~latitude
  ) %>%
  setView(lng = -97.31, lat = 37.69, zoom = 4)%>% 
  
  addLegend(
    position = "bottomright",  
    pal = colorNumeric("YlOrRd", df4$Ice.Cream),  
    values = df4$Ice.Cream,  
    title = "Impuestos de helados en los ultimos 10 años"  
  )
mp5

mp2 <- mp5 %>%
  addMarkers(data=df4,popup = paste0(
    "<strong>Nombre: </strong>", df1$State.Abbr., "<br>",
    "<strong>Población: </strong>", df1$Soda, "<br>"))
mp2