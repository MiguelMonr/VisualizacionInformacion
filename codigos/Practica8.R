#Práctica 8

library(leaflet)
library(dplyr)
library(sf)



df1 <- read.csv("estadosMx.csv")
mxpolig <- st_read("MapaMexico.geojson")
View(df1)
View(mxpolig)

#Mapa interactivo de mexico
mp1 <- leaflet(mxpolig) %>%
  addTiles()%>%
  setView(lng=-99.2,lat=19.34,zoom=4.8)
mp1

#Mapa con marcadores 
mp2 <- leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1)
mp2

#Mapa con nombres
mp2 <- leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1)
mp2

mp2 <- mp2 %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"))
mp2

mp3 <- leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions())
mp3

#NO ME APARECEN LOS BOTONES
mp4 <- leaflet(mxpolig) %>%
  addTiles(group="Mapa base 1") %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addProviderTiles(providers$CartoDB.Positron,group="Mapa base 2")%>%
  addProviderTiles(providers$Esri.NatGeoWorldMap,group="Mapa base 3")%>%
  addLayersControl(
    baseGroups = c("Mapa base 1", "Mapa base 2", "Mapa base 3"),
    options=layersControlOptions(collapsed=TRUE)
  )
mp4

palPob <- colorNumeric("Blues",domain=df1$POB)
mp5<-leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addPolygons(stroke = F,
              smoothFactor = 0.2,
              opacity=1.0,
              fillOpacity = 0.5,
              fillColor = ~palPob(df1$POB),
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT,
              labelOptions = labelOptions(direction = "auto"))%>%
  addLegend(position="bottomleft", pal=palPob, values = ~df1$POB,
            title="Población")%>% 
addLayersControl(overlayGroups = c("Por Población"), options=layersControlOptions(collapsed = F))
mp5


bins <- c(0, 20, 45, 79, 150, 390, 800, 7000)
palDens <- colorBin("Greens", domain = df1$DENS, bins=bins, pretty = F)


mp6<-leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addPolygons(stroke = F,
              smoothFactor = 0.2,
              opacity=1.0,
              fillOpacity = 0.5,
              fillColor = ~palPob(df1$POB),
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT,
              labelOptions = labelOptions(direction = "auto"))%>%
  addLegend(position="bottomleft", pal=palDens, values = ~df1$POB,title="Población")%>%
addLayersControl(overlayGroups = c("Por Población", "Por Densidad"))

options=layersControlOptions(collapsed = TRUE)
mp6


#Por densidad

mp6<-leaflet(mxpolig) %>%
  addTiles(group="Por Densidad") %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$DENS, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addPolygons(stroke = F,
              smoothFactor = 0.2,
              opacity=1.0,
              fillOpacity = 0.5,
              fillColor = ~palDens(df1$DENS),
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT,
              labelOptions = labelOptions(direction = "auto"))%>%
  addLegend(position="bottomleft", pal=palDens, values = ~df1$POB,title="Población") %>%
  
  addLayersControl(overlayGroups = c("Por Población", "Por Densidad"))

options=layersControlOptions(collapsed = T)

mp6


#Por población

palPob <- colorNumeric("Blues",domain=df1$POB)

mp6<-leaflet(mxpolig) %>%
  addTiles(group="Por Población") %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addPolygons(stroke = F,
              smoothFactor = 0.2,
              opacity=1.0,
              fillOpacity = 0.5,
              fillColor = ~palPob(df1$POB),
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT,
              labelOptions = labelOptions(direction = "auto"))%>%
  addLegend(position="bottomleft", pal=palPob, values = ~df1$POB,title="Población") %>%
  addLayersControl(overlayGroups = c("Por Población", "Por Densidad"))

options=layersControlOptions(collapsed = F)

mp6


#bases

mp4 <- leaflet(mxpolig) %>%
  addTiles(group="Mapa base 1") %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addProviderTiles(providers$CartoDB.Positron,group="Mapa base 2")%>%
  addProviderTiles(providers$Esri.NatGeoWorldMap,group="Mapa base 3")%>%
  addLayersControl(overlayGroups = c("Por Población", "Por Densidad"))
options=layersControlOptions(collapsed = T)

mp4
