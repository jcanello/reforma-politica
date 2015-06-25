library(shiny)
library(shinythemes)
library(ggvis)
library(rCharts)

shinyServer(function(input, output) {

 vote %>% 
    ggvis(~xD1, ~xD2, key := ~id) %>%  
    layer_text(text := ~partido, fill = ~partido, 
    	   fontSize := 9) %>% 
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
    layer_text(text := ~partido, fill = ~partido, 
    	   fontSize := 18) %>%
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

 
 output$chart1 <- renderChart({
 	VOTE = input$vote
 	tot <- subset(tots, item == VOTE)
    p1 <- nPlot(value ~ party, group = 'variable', data = tot, 
      type = "multiBarChart")
    p1$chart(color = c('blue', 'red', 'orange', 'gray', 'purple'),
    	 reduceXTicks = FALSE, stacked = TRUE)
    p1$addParams(dom = 'chart1')
    return(p1)
  })

 
})