df <- read.csv("RegistrosQoS.csv" ,header = T)

#Pregunta 2
head(df,10)
library(ggplot2)
library(forcats)
library(dplyr)


#Pregunta 3
miGraf <- ggplot(df, aes(x=Tasa.de.bajada, y=Operador)) +geom_bar(stat= "identity")+coord_flip()
miGraf 

#Pregunta 4
head(df)

dfAux <- df %>% select(Tipo.de.red, RTTAvg) %>% mutate(Tipo.de.red = trimws(Tipo.de.red) ) %>% 
  filter(Tipo.de.red == "LTE" | Tipo.de.red == " EV-DO" | Tipo.de.red == "HSPA+")
head(dfAux,10)

#Prueba 4.1
dfAux <- df %>% filter(Tipo.de.red == "       EDGE") %>% select(RTTAvg, Tipo.de.red) 
head(dfAux)



miGraf1 <- ggplot(dfAux, aes(Tipo.de.red, RTTAvg))
p1 <- miGraf1 + geom_boxplot(varwidth=T, fill = "pink") +
  labs(
    title = "Box plot",
    subtitle = "Consumo en ciudad por tipo de vehículo",
    caption = "Fuente: mpg",
    x = "Tipo de vehículo",
    y = "Consumo en la ciudad"
  )
p1


df2 <- df %>% group_by(Operador) %>%
  count() %>%
  ungroup() %>%
  mutate(porcentaje = 'n'/sum('n')) %>%
  arrange(porcentaje) %>%
  mutate(labels=scales::percent(porcentaje))


