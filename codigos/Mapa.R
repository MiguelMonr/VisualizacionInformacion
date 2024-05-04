library(sf)
library(leaflet)

df1 <- read.csv("FinalFood.csv")
df1

mxpolig <- st_read("states.geojson")
mp1 <- leaflet(mxpolig) %>%
  addTiles()%>%
  setView(lng = -96.7989, lat = 32.7786,zoom=4.4)

mp1


mp2 <- leaflet(mxpolig) %>%
  addTiles() %>%
  addMarkers(data=df1)%>%
  setView(lng = -96.7989, lat = 32.7786,zoom=4.4)
mp2
