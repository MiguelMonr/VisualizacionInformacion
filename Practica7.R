dirAct <- getwd()
print(dirAct)
setwd("CodigosVisInfo")

library(sf)
library(terra)
library(ggplot2)

lst <- rast("MOD11A2_2017-07-12.LST_Day_1km.tif")

class(lst) #El tipo es SpatRaster
head(lst)


#El numero de variables que tiene es 43


lst #Para ver los metadatos del objeto es con este comando 

names(lst)<-c("temperatura")

lst <- ifel(lst == 0, NA, lst)
lst_c <- lst * 0.02 - 273.15

global(lst_c, fun="sd",na.rm=T)

summary(lst_c)


#Codigo para modificar datos raster 

rasterdf <- function(x, aggregate = 10) {
  resampleFactor <- aggregate
  inputRaster <- x
  inCols <- ncol(inputRaster)
  inRows <- nrow(inputRaster)
  # Compute numbers of columns and rows in the resampled raster
  resampledRaster <- rast(ncol=(inCols / resampleFactor),
                          nrow=(inRows / resampleFactor),
                          crs = crs(inputRaster))
  # Match to the extent of the original raster
  ext(resampledRaster) <- ext(inputRaster)
  # Resample data on the new raster
  y <- resample(inputRaster,resampledRaster,method='near')
  # Extract cell coordinates into a data frame
  coords <- xyFromCell(y, seq_len(ncell(y)))
  # Extract layer names
  dat <- stack(values(y, dataframe = TRUE))
  # Add names - 'value' for data, 'variable' for different
  # layer names in a multilayer raster
  names(dat) <- c('value', 'variable')
  dat <- cbind(coords, dat)
  dat
}

df1 <- rasterdf(lst_c)
summary(df1)


#Agregacion de 2
rasterdf2 <- function(x, aggregate = 3) {
  resampleFactor <- aggregate
  inputRaster <- x
  inCols <- ncol(inputRaster)
  inRows <- nrow(inputRaster)
  # Compute numbers of columns and rows in the resampled raster
  resampledRaster <- rast(ncol=(inCols / resampleFactor),
                          nrow=(inRows / resampleFactor),
                          crs = crs(inputRaster))
  # Match to the extent of the original raster
  ext(resampledRaster) <- ext(inputRaster)
  # Resample data on the new raster
  y <- resample(inputRaster,resampledRaster,method='near')
  # Extract cell coordinates into a data frame
  coords <- xyFromCell(y, seq_len(ncell(y)))
  # Extract layer names
  dat <- stack(values(y, dataframe = TRUE))
  # Add names - 'value' for data, 'variable' for different
  # layer names in a multilayer raster
  names(dat) <- c('value', 'variable')
  dat <- cbind(coords, dat)
  dat
}

df2 <- rasterdf2(lst_c)
summary(df2)

# Crea objeto SpatExtent con la extensión geográfica
# que cubre Georgia
clipext <- ext(-86, -80.5, 30, 35.5)
class(clipext)

# Corta las celdas correspondientes a esa extensión geográfica
lst_clip <- crop(lst_c, clipext)
# ... y crea el dataframe correspondiente
lst_clip_df <- rasterdf(lst_clip)

#Cuando se corta lo hace por largo y por ancho 
#lectura de arhivos discreetis 
#En R con que leas el archivo shp ya estas del otro lado


nlc19 <- rast("NLCD_2019_Land_Cover_Walton.tiff")
nlc19

dfAux <- rasterdf(nlc19)

dfAux

ggplot(dfAux) +
  geom_raster(aes(x = x,
                  y = y,
                  fill = value)) +
  scale_fill_gradient(name = "Grados C",
                      low = "lightyellow",
                      high = "red") +
  coord_sf(expand = FALSE) +
  labs(title = "LST-Temperatura ajustada (Terra Day)",
       x = "longitud",
       y = "latitud") +
  theme(legend.position = "bottom")

CodigosLC <- unique(nlc19)[, 1]

NombresLC <-c(
  "Agua",
  "AreaDesarrolladaAbierta",
  "AreaDesarrolladaBaja",
  "AreaDesarrolladaMedia",
  "AreaDesarrolladaAlta",
  "AreaEstéril",
  "BosqueCaducifolio",
  "BosquePerenne",
  "BosqueMixto",
  "MatorralArbustos",
  "Hierba",
  "PastoHeno",
  "Cultivos",
  "Humedales",
  "VegetacionAcuaticaEmergente"
)


puebla <- rast("Puebla_r15m.tif")
dfAuxP <- rasterdf(puebla)

plot(puebla)

