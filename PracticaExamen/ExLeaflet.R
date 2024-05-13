library(sf)
library(leaflet)

esppolig <- st_read("esp.geojson")
hemeroteca <- st_read("TitulosHemeroteca/TitulosHemeroteca.shp")

#Volviendo hemeroteca dataframe
hemeroteca1 <- st_drop_geometry(hemeroteca)
head(hemeroteca1)



mp1 <- leaflet(esppolig) %>%
  addTiles()%>%
  addMarkers(data=hemeroteca,popup=paste0(
    "<strong>Nombre: </strong>", hemeroteca$poblacion, "<br>"
  )
 ) %>%setView(lng = -3.7003, lat = 40.4166, zoom=5)

mp1