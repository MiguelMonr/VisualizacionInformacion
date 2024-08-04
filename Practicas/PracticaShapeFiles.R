install.packages("sf")
install.packages("maps")

library(sf)
library(units)
library(dplyr)
library(ggplot2)
directorio_actual <- getwd()

okcounty <- st_read("ok_counties.shp", quiet = TRUE) #Forma Oklahoma 
tpoint <- st_read("ok_tornado_point.shp", quiet = TRUE)
tpath <- st_read("ok_tornado_path.shp", quiet = TRUE)

#Respuestas 1
#El primero es sf y un dataframe 
#En orden son poligonos, puntos, linestring 

head(okcounty)
head(tpoint)
head(tpath)

#Pregunta dos 
ggplot(data = okcounty) +
  geom_sf() +
  xlab("Longitude") + ylab("Latitude") +
  ggtitle("Oklahoma")

#Pregunta tres 
#Dataset Auxiar tpoint_16_21
tpoint_16_21 <- tpoint %>%
  filter(yr >= 2016 & yr <= 2021) %>%
  select(om, yr, date)

#Dataset Auxiliar 
tpath_16_21 <- tpath %>%
  filter(yr >= 2016 & yr <= 2021) %>%
  select(om, yr, date)

st_crs(tpoint_16_21)
st_crs(tpath)


ggplot() +
  geom_sf(data = okcounty, fill = NA) +
  geom_sf(data = tpoint_16_21) +
  theme_bw()

#Pregunta 6
ggplot() +
  geom_sf(data = tpoint_16_21,
          aes(color = as.factor(yr))) +
  geom_sf(data = okcounty, fill = NA) +
  scale_color_brewer(palette = 1) +
  coord_sf(datum = NA) +
  theme_void()

#Pregunta 7: relacion de tornados con las tablas 
countypnt <- st_join(tpoint_16_21, okcounty)
summary(okcounty)


#Pregunta 8
countypnt <- st_drop_geometry(countypnt)
countysum <- countypnt %>%
  group_by(GEOID) %>%
  summarize(tcnt = n())

#Pregunta 9 
countymap <- okcounty %>%
  left_join(countysum, by = "GEOID") %>%
  replace(is.na(.), 0) %>%
  mutate(area = st_area(okcounty),
         tdens = 10^6 * 10^3 * tcnt / area) %>%
  drop_units()

#Tiene 77 observaciones y 11 variables. Adicionalmente tiene area y geometria 

#Pregunta 10

