directorio_actual <- getwd()
setwd("/Users/miguela.monreal/CodigosVisInfo/codigos") #Esto sirve para establecer la carpeta en la que quieres trabajar 


datos <- read.csv("FoodTaxes.csv")
str(datos)
head(datos,6)

library(ggplot2)
datos$Year <- as.factor(datos$Year)
miGraf <- ggplot(datos, aes(Year, Disfavored.tax..Soda..Y.N.,))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "pink") +
  labs(title = "Box plot", subtitle = "Taxes por año", 
       x = "Año ", y = "Consumo")

#taxes de Soda

miGraf <- ggplot(datos, aes(Year, Sales.Tax..regular.soda..VM.))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de soda", 
       x = "Año ", y = "Consumo")

#Taxes de agua
miGraf <- ggplot(datos, aes(Year, Sales.Tax.rate.Bottled.Water ))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de agua", 
       x = "Año ", y = "Consumo")

#taxes de candy
miGraf <- ggplot(datos, aes(Year, Sales.tax..Candy))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de Candy", 
       x = "Año ", y = "Consumo")

#taxes de chicle
miGraf <- ggplot(datos, aes(Year, Sales.Tax..Gum))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de chicle", 
       x = "Año ", y = "Consumo")

#Taxes papitas
miGraf <- ggplot(datos, aes(Year, Sales.Tax..Chips..Pretzels..VM.))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de frituras", 
       x = "Año ", y = "Consumo")

#Taxes de helado
miGraf <- ggplot(datos, aes(Year, Sales.Tax..Ice.Cream))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de helado", 
       x = "Año ", y = "Consumo")

#Taxes de popsicles
miGraf <- ggplot(datos, aes(Year, Sales.Tax..Popsicle ))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de popsicles", 
       x = "Año ", y = "Consumo")
#Taxes malteadas
miGraf <- ggplot(datos, aes(Year, Sales.Tax..Milkshakes..Baked.Goods ))

miGraf +  geom_boxplot(varwidth = TRUE, fill = "blue") +
  labs(title = "Box plot", subtitle = "Taxes de malteadas", 
       x = "Año ", y = "Consumo")



