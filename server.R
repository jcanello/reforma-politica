library(shiny)
library(ggvis)

vote <- read.csv("data/camara.csv")
vote$urlFoto <- as.character(vote$urlFoto)
vote$email <- as.character(vote$email)

nameparty <- function(x) {
  if(is.null(x)) return(NULL)
  row <- vote[vote$id == x$id, c('name', 'partido', 'uf')]
  paste0(format(row), collapse = " - ")
}

shinyServer(function(input, output) {

 vote %>% 
    ggvis(~xD1, ~xD2, key := ~id) %>%  
    layer_points(fill = ~partido, size.hover := 300) %>%
    add_tooltip(nameparty, "hover") %>%
    bind_shiny("ideal", "ideal_ui")

  
      
})