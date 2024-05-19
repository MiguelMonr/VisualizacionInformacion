directorio_actual <- getwd()
setwd("/Users/miguela.monreal/CodigosVisInfo/codigos") #Esto sirve para establecer la carpeta en la que quieres trabajar 


datos <- read.csv("v2Abril.csv")
str(datos)
head(datos)
show(datos)

library(ggplot2)
library(dplyr)
library(gridExtra)

datos$Year <- as.factor(datos$Year)
miGraf <- ggplot(datos, aes(Year, Disfavored.tax..Soda..Y.N.,))

#Forma de ggplot
miGraf +  geom_boxplot(varwidth = TRUE, fill = "pink") +
  labs(title = "Box plot", subtitle = "Taxes por año", 
       x = "Año ", y = "Consumo")

#taxes de Soda

miGraf1 <- ggplot(datos, aes(Year,Soda))

miGraf11 <- miGraf1+  geom_boxplot(varwidth = TRUE, fill = "#ffab00") +
  labs(title = "Distribucion de los precios a lo largo de los años " , subtitle = "Taxes de soda", 
       x = "Año ", y = "Precio impuesto")
miGraf11

#Taxes papitas
miGraf2 <- ggplot(datos, aes(Year, Chips..Pretzels))

miGraf22 <- miGraf2 +  geom_boxplot(varwidth = TRUE,fill = "#008f21") +
  labs(title = "Distribucion de los precios a lo largo de los años ", subtitle = "Taxes de frituras", 
       x = "Año ", y = "Precio impuesto")
miGraf22

#Taxes de helado
miGraf3 <- ggplot(datos, aes(Year, Ice.Cream))

miGraf33<- miGraf3 +  geom_boxplot(varwidth = TRUE, fill = "#d500f9") +
  labs(title = "Distribucion de los precios a lo largo de los años ", subtitle = "Taxes de helado", 
       x = "Año ", y = "Precio impuesto")
miGraf33

grid.arrange(miGraf11,miGraf33)


promedios_por_anioS <- datos %>%
  group_by(Year) %>%
  summarise(promedio_soda = mean(Soda))

promedios_por_anioI <- datos %>%
  group_by(Year) %>%
  summarise(promedio_I = mean(Ice.Cream ))

promedios_por_anioP <- datos %>%
  group_by(Year) %>%
  summarise(promedio_P = mean(Chips..Pretzels ))

print(promedios_por_anioS)





#Grafica de puntos
miGrafS <- ggplot(promedios_por_anioS, aes(x=factor(Year), y=promedio_soda)) +
  geom_point(size=2, color= "#ffab00") +
  geom_smooth(method="lm", se=FALSE) +
  ggtitle("Evolucion de costos promedios en Estados Unidos: Soda") +
  xlab("Año") +
  ylab("Promedio de Soda")

miGrafS

miGrafI <- ggplot(promedios_por_anioI, aes(x=factor(Year), y=promedio_I)) +
  geom_point(size=2, color= "#d500f9") +
  geom_smooth(method="lm", se=FALSE) +
  ggtitle("Evolucion de costos promedios en Estados Unidos: Helado") +
  xlab("Año") +
  ylab("Promedio de Helado")

miGrafI

miGrafP <- ggplot(promedios_por_anioP, aes(x=factor(Year), y=promedio_P)) +
  geom_point(size=2, color= "#008f21") +
  geom_smooth(method="lm", se=FALSE) +
  ggtitle("Evolucion de costos promedios en Estados Unidos: Frituras y Soda") +
  xlab("Año") +
  ylab("Promedio de Frituras")
miGrafP

miGrafS + miGrafP
grid.arrange(miGrafS, miGrafP,miGrafI)


#Uniendo 
merged_df <- promedios_por_anioI %>%
  left_join(promedios_por_anioS, by = "Year") %>%
  left_join(promedios_por_anioP, by = "Year")

# Mostrar el dataframe resultante
head(merged_df) #DataFrames con promedios


#Grafica de histogramas
ggplot(merged_df, aes(x = as.factor(Year), y = promedio_I)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Promedio_I por año",
       x = "Año",
       y = "Promedio_I") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 


#Grafica de barras apiladas

plot1 <- ggplot(mtcars, aes(x = mpg, y = disp)) +
  geom_point()
plot1

# Gráfico 2
plot2 <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()
plot2


grid.arrange(plot1, plot2, ncol = 2)






