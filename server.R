library(shiny)
library(ggvis)

vote <- read.csv("data/camara.csv")[-1:-2]
vote$urlFoto <- as.character(vote$urlFoto)
vote$email <- as.character(vote$email)
vote$nome <- as.character(vote$nome)
orient <- read.csv("data/partidos.csv")
names(orient)[1] <- "partido"

nameparty <- function(x) {
  if(is.null(x)) return(NULL)
  row <- vote[vote$id == x$id, c('nome', 'partido', 'uf')]
  paste0(format(row), collapse = " - ")
}

party <- function(x) {
  if(is.null(x)) return(NULL)
  paste0(names(x), ": ", format(x), collapse = "<br />")
}

shinyServer(function(input, output) {

 vote %>% 
    ggvis(~xD1, ~xD2, key := ~id) %>%  
    layer_text(text := ~partido, fill = ~partido, fontSize := 8) %>%
 add_tooltip(nameparty, "hover") %>%
 	add_axis("x", title = "", subdivide = 9, values = -2.5:2.3, tick_size_major = 10,
 		 tick_size_minor = 5, tick_size_end = 15, tick_padding = 20 ) %>% 
 	add_axis("y", title = "", subdivide = 9, values = -2.5:2, tick_size_major = 10,
 		 tick_size_minor = 5, tick_size_end = 15, tick_padding = 20) %>%
 		scale_nominal("fill", range =  c("darkgoldenrod", #DEM
   "orangered", #PCdoB
   "navy", #PDT
   "darkgreen", # PEN
   "firebrick", # PHS
   "saddlebrown", #PMDB
   "khaki", # PMN
   "yellowgreen", # PP
   "orange", #PPS
   "purple", #PR
   "violetred",  #PRB
   "darkcyan", #PROS
   "slategray", # PRP
   "peru", # PRTB
   "tomato", #PSB
   "chocolate", #PSC
   "seagreen", #PSD
   "blue", #PSDB
   "blueviolet", # PSDC
   "coral", # PSL
   "sienna", #PSOL
   "red", #PT
   "sandybrown", # PTB
   "black",	# PTC
   "aquamarine",	# PT do B
   "dimgrey",	# PTN
   "green", #PV
   "gold", #SD
   "indianred")) %>%
    bind_shiny("ideal", "ideal_ui")

 
 orient %>% 
    ggvis(~xD1, ~xD2, stroke := ~partido) %>%  
    layer_text(text := ~partido, fill = ~partido, fontSize := 18) %>%
    add_tooltip(party, "hover") %>%
 	add_axis("x", title = "", subdivide = 9, values = -1.5:2, tick_size_major = 10,
 		 tick_size_minor = 5, tick_size_end = 15, tick_padding = 20 ) %>% 
 	add_axis("y", title = "", subdivide = 9, values = -1.5:2, tick_size_major = 10,
 		 tick_size_minor = 5, tick_size_end = 15, tick_padding = 20) %>%
	scale_nominal("fill", range = c("saddlebrown", "violetred", "darkgoldenrod",
					"orangered", "navy", "orange",
					"purple", "darkcyan", "tomato",
					"seagreen", "blue", "sienna",
					"red", "green", "gold")) %>%
 	bind_shiny("oideal", "oideal_ui")

     
})