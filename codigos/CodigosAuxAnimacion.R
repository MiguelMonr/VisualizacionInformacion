
install.packages("gifski")
library(gifski)
library(ggplot2)
library(gganimate)


p<-ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

animate(p, renderer=gifski_renderer())

p <- ggplot(
  airquality,
  aes(Day, Temp, group = Month, color = factor(Month))
) +
  geom_line() +
  scale_color_viridis_d() +
  labs(x = "Día del mes", y = "Temperatura (Farenheit)")  + transition_reveal(Day)+
  theme(legend.position = "top")

animated_plot <- p + transition_reveal(Day)
animate(animated_plot, renderer = gifski_renderer())
p
#Ahora animando la grafica 


