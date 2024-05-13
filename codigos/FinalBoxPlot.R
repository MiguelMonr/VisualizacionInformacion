library(ggplot2)
library(dplyr)

setwd("/Users/miguela.monreal/CodigosVisInfo/codigos/")
data <- read.csv("v2Abril.csv")
head(data,6)


summary(data)


#Conviriendo los datos
data$Year <- as.factor(datos$Year)


#Grafica de soda
ggplot(data, aes(x=Region, y= Soda,)) +
  geom_bar(stat= "identity",position= "dodge", fill = "red") +  
  labs(title = "Ventas de Soda por Región",
       x = "Región",
       y = "Precio de tax") +
  


#Grafica de helado
ggplot(data, aes(x = Region, y = Ice.Cream)) +
  geom_bar(stat = "identity",position="dodge",fill = "skyblue") + 
  labs(title = "Ventas de Helado por Región",
       x = "Región",
       y = "Precio de tax") +
  theme_minimal() 

#Grafica de Chips
ggplot(data, aes(x = Region, y = Chips..Pretzels)) +
  geom_bar(stat = "identity", position= "dodge", fill = "green") + 
  labs(title = "Ventas de Chips por Región",
       x = "Región",
       y = "Precio de tax") +
  theme_minimal()

#Por estado
ggplot(data, aes(x = Region, y = State.Food.Sales.Tax.Rate)) +
  geom_bar(stat = "identity", position = "dodge", fill = "orange") +  
  labs(title = "Taxes de comida por region",
       x = "Región",
       y = "Precio de tax") +
  theme_minimal()

#taxes
ggplot(data, aes(x = Region, y =State.Sales.Tax.Rate )) +
  geom_bar(stat = "identity", position= "dodge", fill = "blue") +  
  labs(title = "Taxes de comida por region",
       x = "Región",
       y = "Precio de tax") +
  theme_minimal()


