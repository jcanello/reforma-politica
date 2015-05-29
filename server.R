library(shiny)
library(ggvis)


vote <- read.csv("data/camara.csv", dec = ",")
vote$urlFoto <- as.character(vote$urlFoto)
vote$email <- as.character(vote$email)
orient <- read.csv("data/partidos.csv", dec = ",")


nameparty <- function(x) {
  if(is.null(x)) return(NULL)
  row <- vote[vote$id == x$id, c('name', 'partido', 'uf')]
  paste0(format(row), collapse = " - ")
}

party <- function(x) {
  if(is.null(x)) return(NULL)
  row <- orient[orient$partido == x$partido, c('partido')]
  paste0(format(row))
}

shinyServer(function(input, output) {

 vote %>% 
    ggvis(~xD1, ~xD2, key := ~id) %>%  
    layer_points(fill = ~partido, size.hover := 300) %>%
    add_tooltip(nameparty, "hover") %>%
    bind_shiny("ideal", "ideal_ui")

 orient %>% 
    ggvis(~xD1, ~xD2, stroke := ~partido) %>%  
    layer_points(fill = ~partido, size.hover := 300) %>%
    add_tooltip(party, "hover") %>%
    bind_shiny("oideal", "oideal_ui")
  
      
})