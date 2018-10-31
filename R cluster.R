

install.packages("plotly")

library(plotly)
library(knitr)
summary(breweries)
library(RColorBrewer)


beer_popular <- beers %>% 
  group_by(style) %>% 
  mutate(n = n()) %>% 
  filter(n >= 25, !(style %in% c("KÃ¶lsch","MÃ¤rzen / Oktoberfest")))
plot_ly(beer_popular, x = ~abv, y = ~ibu, z = ~ounces, color = ~style, 
        colors = colorRampPalette(brewer.pal(11,"Spectral"))(100), hoverinfo = 'text', text = ~paste('</br>Beer: ', name,
                                                                                                     '</br>Style: ', style,                                                                                                 '</br> Ounces: ', ounces)) %>%
  add_markers() %>%                                                          
  layout(scene = list(xaxis = list(title = 'ABV'),
                      yaxis = list(title = 'IBU'),
                      zaxis = list(title = 'Ounces')))
 
api_create(beer_popular, filename = "cluster")

