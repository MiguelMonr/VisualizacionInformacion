library(sf)
library(leaflet)
df1 <- read.csv("estadosMx.csv")
mxpolig <- st_read("MapaMexico.geojson")
head(mxpolig) #Este tiene la forma de los estados
head(df1) #Este tiene la ubicacion de donde se encuentran las capitale

#Desplegando el mapa
mp1 <- leaflet(mxpolig) %>%
  addTiles()%>%
  setView(lng=-99.2,lat=19.34,zoom=7) #En setview establecemos donde queremos la vista inicial

mp1

#pregunta 2
mp1 <- leaflet(mxpolig) %>%
  addTiles()%>%
  setView(lng=-99.2,lat=19.34,zoom=2) #En setview establecemos donde queremos la vista inicial

mp1

#En este caso añadimos como marcador la capital, esa informacion se encuentra el df1
mp2 <- leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1)%>%
  setView(lng=-99.2,lat=19.34,zoom=4.4)
mp2

#Añadiendo pop ups
mp2 <- mp2 %>%
  addMarkers(data=df1,popup = paste0( #para añadir markers primero indicas de donde los vas a sacar
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>", #Posteriormente indicas la columna de ese df
    "<strong>Población: </strong>", df1$POB, "<br>"))
mp2


#Pregunta 3
mp2 <- mp2 %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>",
    "<strong>Densidad Pob: </strong>", df1$DENS, "<br>"))
mp2


#Pregunta 4.
mp3 <- leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Poblaci?n: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) #Esta opcion es por indicar los clusters
mp3


#Mapa con botones

# 5. Añadimos opciones para mapas base

mp4 <- leaflet(mxpolig) %>%
  addTiles(group="Mapa base 1") %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addProviderTiles(providers$CartoDB.Positron,group="Mapa base 2")%>% #CartoDB es para los mapas
  addProviderTiles(providers$Esri.NatGeoWorldMap,group="Mapa base 3")%>%
  addLayersControl(
    baseGroups = c("Mapa base 1", "Mapa base 2", "Mapa base 3"),
    options=layersControlOptions(collapsed=T)
  )


mp4

#Añadiendo mapas de coropletas
palPob <- colorNumeric("Blues",domain=df1$POB) #Elegimos el tipo de paleta que utilizaremos y de donde sacara los datos

mp5<-leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addPolygons(stroke = F, #En addPolygons indicaps como se van a colorear los poligonos
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
            title="Población")


mp5

#Mapa para densidad de poblacion
palDens <- colorBin("Greens", domain = df1$DENS, 6, pretty = F)

mp5.1<-leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addPolygons(stroke = F, #En addPolygons indicaps como se van a colorear los poligonos
              smoothFactor = 0.2,
              opacity=1.0,
              fillOpacity = 0.5,
              fillColor = ~palDens(df1$DENS),
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT,
              labelOptions = labelOptions(direction = "auto"))%>%
  addLegend(position="bottomleft", pal=palDens, values = ~df1$DENS,
            title="Población")


mp5.1

bins <- c(0, 20, 45, 79, 150, 390, 800, 7000) #Aqui definomos los limites del intervalo 
palDens <- colorBin("Greens", domain = df1$DENS, bins=bins, pretty = F)
#En domain indicamos los datos a usar y bins el tamaño de los intervalos

mp6<-leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addPolygons(stroke = F, #En addPolygons indicaps como se van a colorear los poligonos
              smoothFactor = 0.2,
              opacity=1.0,
              fillOpacity = 0.5,
              fillColor = ~palDens(df1$DENS),
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT,
              labelOptions = labelOptions(direction = "auto"))%>%
  addLegend(position="bottomleft", pal=palDens, values = ~df1$DENS,
            title="Población")


mp6


mp7 <- leaflet(mxpolig) %>%
  addTiles(group="Mapa base 1") %>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>"),
    clusterOptions = markerClusterOptions()) %>%
  addProviderTiles(providers$CartoDB.Positron,group="Mapa base 2")%>%
  addProviderTiles(providers$Esri.NatGeoWorldMap,group="Mapa base 3")%>%
  addLayersControl(baseGroups=list( mp5.1, mp6), overlayGroups = c("Por Población", "Por Densidad"))
options=layersControlOptions(collapsed = T)

mp7

#Mapa en su totalidad

mp10 <- leaflet(mxpolig) %>%
  addTiles() %>%
  addPolygons(stroke = F, smoothFactor = 0.2, opacity=1.0, 
              fillOpacity = 0.5, fillColor = ~palPob(df1$POB), 
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT, labelOptions = labelOptions(direction = "auto"),
              group="Por Población")%>%
  addLegend(position="bottomleft", pal=palPob, values = ~df1$POB,
            title="Población", group="Por Población") %>%
  addPolygons(stroke = F, smoothFactor = 0.2, opacity=1.0,
              fillOpacity = 0.5, fillColor = ~palDens(df1$DENS),
              highlightOptions = highlightOptions(color="white",
                                                  weight=2,
                                                  bringToFront = T),
              label=df1$NOM_ENT, labelOptions = labelOptions(direction = "auto"),
              group = "Por Densidad")%>%
  addLegend(position="bottomleft", pal=palDens, values = ~df1$DENS,
            labFormat=labelFormat(digits=0), group = "Por Densidad",
            title="Densidad")%>%
  addMarkers(data=df1,popup = paste0(
    "<strong>Nombre: </strong>", df1$NOM_ENT, "<br>",
    "<strong>Población: </strong>", df1$POB, "<br>",
    "<strong>Densidad Poblacional: </strong>", df1$DENS, "<br>"),
    clusterOptions = markerClusterOptions())%>%
  addProviderTiles(providers$CartoDB.Positron,group="Mapa base 2")%>%
  addProviderTiles(providers$Esri.NatGeoWorldMap,group="Mapa base 3")%>%
  addLayersControl(
    baseGroups = c("Mapa base 1", "Mapa base 2", "Mapa base 3"),
    overlayGroups = c("Por Población", "Por Densidad"), 
    options=layersControlOptions(collapsed=F))

mp10




