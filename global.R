library(shiny)
library(shinythemes)
library(ggvis)
library(rCharts)

vote <- read.csv("data/camara.csv")[-1:-2]
vote$urlFoto <- as.character(vote$urlFoto)
vote$email <- as.character(vote$email)
vote$nome <- as.character(vote$nome)
orient <- read.csv("data/partidos.csv")
names(orient)[1] <- "partido"
tots <- read.csv("data/tots.csv")[-1]

nameparty <- function(x) {
  if(is.null(x)) return(NULL)
  row <- vote[vote$id == x$id, c('nome', 'partido', 'uf')]
  paste0(format(row), collapse = " - ")
}

party <- function(x) {
  if(is.null(x)) return(NULL)
  paste0(names(x), ": ", format(x), collapse = "<br />")
}