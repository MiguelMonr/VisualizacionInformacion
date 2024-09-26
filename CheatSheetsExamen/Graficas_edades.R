library("ggplot2")

df_edades<- read.csv("/Users/miguelmonreal/Desktop/VisualizacionInformacion/poblaciones_edades.csv")
grafica_edades <- ggplot(mpg, aes(x = Grupo.quinquenal.de.edad.descriptivo, fill = drv))
