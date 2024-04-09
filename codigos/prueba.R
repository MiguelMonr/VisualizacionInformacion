
#install.packages("patchwork")
library(patchwork)
library(ggplot2)
data <- data.frame(letra = LETTERS[1:5], val = c(50, 220, 100, 300, 190))
p1 <- ggplot(data, aes(letra, val)) +
  geom_bar(stat = "identity")

p2 <- ggplot(data, aes(letra, val)) +
  geom_bar(stat = "identity") +
  coord_polar()

p1 + p2