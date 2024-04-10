#Pregunta 1
df <- read.csv("chicago-nmmaps-custom.csv")
df$date <- as.Date(df$date)
str(df)

summary(df,6)
head(df,6)

#Pregunta 2
library(ggplot2)

miGraf <- ggplot(df, aes(date, temp)) + geom_point(aes(color = season)) + labs("examen", y="temperatura", x= "fecha") + theme_bw()
miGraf

#Pregunta 3 grafica de bigotes
miGraf1 <- ggplot(df, aes(season,o3))
g <- miGraf1 + geom_boxplot(fill =" lightblue") + coord_flip()
g 

#La estacion con mayor numero de extemos es la primavera, el valor con la mediana mas pequeña es otoño

#Pregunta 4
df2 <- df %>% mutate(o3_avg = median(o3)) %>%
  filter(o3>o3_avg)%>%
  mutate(n_all = n()) %>%
  group_by(season)%>%
  summarise(porcentaje = n() / unique(n_all))%>%
  arrange(porcentaje)%>%
  mutate(labels=scales::percent(porcentaje))

head(df2)

pie <- ggplot(df2, aes(x = "", fill = factor(porcentaje))) + # Solo se pone como parametro el de las clases
  geom_bar(width = 1) +
  theme(
    axis.line = element_blank(),
    plot.title = element_text(hjust = 0.5)
  ) +
  labs(
    fill = "class",
    x = NULL,
    y = NULL,
    title = "Pie Chart of class",
    caption = "Source: mpg"
  )
pie + coord_polar(theta = "y", start = 0) 

#Pregunta 5
library(patchwork)
hist <- ggplot(df, aes(temp)) + geom_histogram(aes(y = ..density.. ), fill="black", bins = 15)+ geom_density(adjust=2,color="red" ,fill = "gray80",alpha= 0.5  )

hist #Tiene una distribucion bimodal


#Pregunta 7



