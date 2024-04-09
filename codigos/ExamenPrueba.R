df <- read.csv("RegistrosQoS.csv" ,header = T)

#Pregunta 2
head(df,10)
library(ggplot2)
library(forcats)
library(dplyr)
library(igraph)
library(ggraph)
library(tidyverse)


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

#Pregunta 5
#1) sí, son los nodos mas grandes de la red
#2) Los que tienen el grado más alto son 8,10,2
#3) No beben alcohol en exceso ni comenten delitos. Su tamaño es de los más pequeños y sus rangos de alcohol son dentre 1 y 2


#Ultima pregunta
#Los que le reportan mas a un superior son las hojas
grafo <- read.csv("datosJerarquia.csv")
g <- graph_from_data_frame(grafo, directed = T)
ggraph(g, layout= "dendrogram")+ geom_edge_diagonal() +     geom_node_text(aes(label = name, filter = !leaf),
                                                                           nudge_x = 0.3, angle = 30
)

#Volviendolo aahora circular
ggraph(g, layout= "dendrogram", circular = T)+ geom_edge_diagonal() +     geom_node_text(aes(label = name, filter = !leaf),
                                                                           nudge_x = 0.3, angle = 30
)

#No es apropiado para representar jerarquias 
