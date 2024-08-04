#Segunda parte

library(ggraph)
library(igraph)
library(treemapify)
library(tidyverse)

pt2 <- read.csv("EmisPaisGDP.csv")
head(pt2, 6)

ggplot(pt2, aes(area = Emisiones,fill = Emisiones, label= Pais, subgroup= Region)) +   geom_treemap() +
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(
    place = "center", row = T, alpha = 0.5, color = "white",
    fontface = "italic", min.size = 0
  ) +
  geom_treemap_text(color = "red", place = "topleft", reflow =T)
#El continente que mas genera es Asia, y el que menos genera es Oceania. 
#El pais que mas genera en Asia es Qatar, al reddor de 40 


