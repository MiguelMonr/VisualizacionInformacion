library(sf)
library(ggplot2)
library(dplyr)
library(RColorBrewer)
library(scales)


df1 <- st_read("/Users/miguelmonreal/Desktop/VisualizacionInformacion/Notebooks/MapaMexico.geojson")

df1 #Esta es la grafica

ggplot(df1) +
  geom_sf() + #* geom_sf es el metodo para graficar. En mapping ponemos las variables a corolear
  coord_sf() 

str(df1)

#Sin geometria
sin_geometria <- st_drop_geometry(df1)
sin_geometria_limpio <- sin_geometria %>% select(AREA,PERIMETER,ENTIDAD,CAPITAL)
sin_geometria_limpio

#Cargano con poblaciones
poblaciones <- read.csv("/Users/miguelmonreal/Desktop/VisualizacionInformacion/nueva_poblacion2.csv")
str(poblaciones)

# Supongamos que tu dataframe se llama df
# Convertir las columnas a numéricas en el dataframe poblaciones
poblaciones$Total <- as.numeric(gsub(",", "", poblaciones$Total))
poblaciones$Hombres <- as.numeric(gsub(",", "", poblaciones$Hombres))
poblaciones$Mujeres <- as.numeric(gsub(",", "", poblaciones$Mujeres))

# Verifica el tipo de datos
str(poblaciones)
summary(poblaciones)

#Capitalizando 
poblaciones$Entidad.federativa <- toupper(poblaciones$Entidad.federativa)
poblaciones

#Para edoMex
poblaciones$Entidad.federativa[poblaciones$Entidad.federativa == "MÉXICO"] <- "EDO. MEX"
poblaciones$Entidad.federativa[poblaciones$Entidad.federativa == "QUERÉTARO"] <- "QUERETARO DE ARTEAGA"
sin_geometria_limpio$ENTIDAD[sin_geometria_limpio$ENTIDAD == "MEXICO"] <- "EDO. MEX"
sin_geometria_limpio$ENTIDAD[sin_geometria_limpio$ENTIDAD == "MICHOACAN DE OCAMPO"] <- "MICHOACÁN DE OCAMPO"
sin_geometria_limpio$ENTIDAD[sin_geometria_limpio$ENTIDAD == "SAN LUIS POTOSI"] <- "SAN LUIS POTOSÍ"
sin_geometria_limpio$ENTIDAD[sin_geometria_limpio$ENTIDAD == "NUEVO LEON"] <- "NUEVO LEÓN"
sin_geometria_limpio$ENTIDAD[sin_geometria_limpio$ENTIDAD == "YUCATAN"] <- "YUCATÁN"

#Modificando registros para que notacion coincida
#EdoMex, MICHOACAN DE OCAMPO, Nuevo Leon, San Luis, Yucatan
df1$ENTIDAD[df1$ENTIDAD == "MEXICO"] <- "EDO. MEX"
df1$ENTIDAD[df1$ENTIDAD == "MICHOACAN DE OCAMPO"] <- "MICHOACÁN DE OCAMPO"
df1$ENTIDAD[df1$ENTIDAD == "SAN LUIS POTOSI"] <- "SAN LUIS POTOSÍ"
df1$ENTIDAD[df1$ENTIDAD == "NUEVO LEON"] <- "NUEVO LEÓN"
df1$ENTIDAD[df1$ENTIDAD == "YUCATAN"] <- "YUCATÁN"



#Primero haciendo join de columnas numericas
df_final <- sin_geometria_limpio %>%
  left_join(poblaciones, by = c("ENTIDAD" = "Entidad.federativa")) %>%
  select(AREA, PERIMETER, ENTIDAD, CAPITAL, Total, Hombres, Mujeres)

# Mostrar el dataframe resultante
print(df_final)



#Par ver si sirven
# Asegúrate de que la columna ENTIDAD sea del mismo tipo en ambos dataframes
resultado <- resultado %>%
  mutate(ENTIDAD = as.character(ENTIDAD)) # Asegúrate de que sea del mismo tipo

# Realiza el join para agregar la geometría
resultado_final <- resultado %>%
  left_join(df1 %>% select(ENTIDAD, geometry), by = "ENTIDAD")

# Verifica que la columna geometry se haya añadido correctamente
if("geometry" %in% colnames(resultado_final)) {
  # Convierte resultado_final a un objeto sf utilizando la geometría existente
  resultado_final <- st_as_sf(resultado_final, sf_column_name = "geometry", crs = st_crs(df1))
} else {
  stop("No se pudo encontrar la columna 'geometry' en resultado_final.")
}

resultado_final



#Mapa
df1
ggplot(df1) +
  geom_sf() + #* geom_sf es el metodo para graficar. En mapping ponemos las variables a corolear
  coord_sf() 

#Primer intento
ggplot(data = resultado_final) +  # df_final es tu Simple Features object con la geometría y los datos
  geom_sf(aes(fill = Total), color = "white") +  # Rellenar los polígonos según la columna Total
  scale_fill_distiller(palette = "YlOrRd", name = "Población Total", direction = 1) +  # Usar una paleta de colores de RColorBrewer
  labs(title = "Mapa de Coropletas: Población Total por Estado",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom")

#total poblacion 
pob <- resultado_final$Total
pob

#Segundo intento
ggplot(data = resultado_final) +  # df_final es tu Simple Features object con la geometría y los datos
  geom_sf(aes(fill = Total), color = "white") +  # Rellenar los polígonos según la columna Total
  scale_fill_distiller(palette = "YlOrRd", name = "Población Total", direction = 1,
                       labels = comma_format(big.mark = ",")) +  # Ajustar el formato de la escala
  labs(title = "Mapa de Coropletas: Población Total por Estado",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom")

#Tercer intento
ggplot(data = resultado_final) +  # df_final es tu Simple Features object con la geometría y los datos
  geom_sf(aes(fill = Total), color = "white") +  # Rellenar los polígonos según la columna Total
  scale_fill_distiller(palette = "YlOrRd", 
                       name = "Población Total", 
                       direction = 1, 
                       breaks = c(2000000, 4000000, 6000000, 8000000, 10000000, 15000000, 20000000),
                       labels = comma_format(big.mark = ",")) +  # Ajustar el formato y los breaks
  labs(title = "Mapa de Coropletas: Población Total por Estado",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom")


#Cuarto intento
ggplot(data = resultado_final) +  # df_final es tu Simple Features object con la geometría y los datos
  geom_sf(aes(fill = Total), color = "white") +  # Rellenar los polígonos según la columna Total
  scale_fill_distiller(palette = "YlOrRd", 
                       name = "Población Total", 
                       direction = 1, 
                       breaks = c(1500000, 4000000, 6000000, 9000000, 17000000),  # Ajustar los breaks según los datos
                       labels = label_number(scale = 1e-6, suffix = "M")) +  # Mostrar en millones con "M"
  labs(title = "Mapa de Coropletas: Población Total por Estado",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom")

#Quinto intento
ggplot(data = resultado_final) +  # df_final es tu Simple Features object con la geometría y los datos
  geom_sf(aes(fill = Total), color = "white") +  # Rellenar los polígonos según la columna Total
  scale_fill_distiller(palette = "YlOrRd", 
                       name = "Población Total", 
                       direction = 1, 
                       breaks = c(1500000, 4000000, 6000000, 9000000, 17000000),  # Ajustar los breaks para incluir los valores extremos
                       labels = label_number(scale = 1e-6, suffix = "M")) +  # Mostrar en millones con "M"
  labs(title = "Mapa de Coropletas: Población Total por Estado",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom")



ggplot(data = resultado_final) +  # df_final es tu Simple Features object con la geometría y los datos
  geom_sf(aes(fill = Total), color = "white") +  # Rellenar los polígonos según la columna Total
  scale_fill_distiller(palette = "YlOrRd", 
                       name = "Población Total", 
                       direction = 1, 
                       breaks = c(1500000, 4000000, 6000000, 9000000, 17000000),  # Ajustar los breaks para incluir los valores extremos
                       labels = label_number(scale = 1e-6, suffix = "M")) +  # Mostrar en millones con "M"
  labs(title = "Mapa de Coropletas: Población Total por Estado",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom",
        legend.key.width = unit(2.5, "cm"))


#Para valores discretos
resultado_final$Poblacion_categoria <- cut(df_final$Total, 
                                    breaks = c(0, 3000000, 6000000, 9000000, 12000000, 17000000), 
                                    labels = c("< 3M", "3M-6M", "6M-9M", "9M-12M", "> 12M"))

# Crear el mapa de coropletas con valores discretos
ggplot(data = resultado_final) +  # df_final es tu Simple Features object con la geometría y los datos
  geom_sf(aes(fill = Poblacion_categoria), color = "white") +  # Rellenar los polígonos según la categoría de población
  scale_fill_brewer(palette = "YlOrRd", name = "Población Total") +  # Usar una paleta discreta de RColorBrewer
  labs(title = "Mapa de Coropletas: Población Total por Estado (Valores Discretos)",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom",
        legend.key.width = unit(2.5, "cm")) 

#intento 123
resultado_final$Poblacion_categoria <- cut(resultado_final$Total, 
                                           breaks = c(0, 2000000, 4000000, 6000000, 9000000, 17000000), 
                                           labels = c("[0-2M]", "(2M-4M]", "(4M-6M]", "(6M-9M]", "(>9M)"))

# Crear el mapa de coropletas con valores discretos y leyenda en clases con intervalos
ggplot(data = resultado_final) +  
  geom_sf(aes(fill = Poblacion_categoria), color = "white") +  # Rellenar según la categoría de población
  scale_fill_brewer(palette = "Blues", name = "Población Total") +  # Usar una paleta de colores discreta
  labs(title = "Mapa de Coropletas: Población Total por Estado (Escala Discreta)",
       subtitle = "México",
       caption = "Fuente: INEGI") +
  theme_minimal() +
  theme(legend.position = "bottom",
        legend.title = element_text(size = 12),  # Ajustar el tamaño del título de la leyenda
        legend.text = element_text(size = 10),   # Ajustar el tamaño del texto de la leyenda
        legend.key.width = unit(2.5, "cm"))
 


