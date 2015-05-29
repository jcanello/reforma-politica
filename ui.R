library(shiny)
library(shinythemes)
library(ggvis)

# Define the overall UI with a navbar
shinyUI(navbarPage("Reforma Política", theme = "sandstone.css",
		   tabPanel("Mapa dos Deputados",
		   	   
  # Use a fluid Bootstrap layout
  fluidPage(   
    
    # Generate a row 
    fluidRow(      
      
      # Create a spot for the tabs and plots
      mainPanel(
      	      	tabsetPanel(
      	  	tabPanel("Ideal", uiOutput("ideal_ui"), ggvisOutput("ideal")))),

      # Define the sidebar 
      sidebarPanel(
         h3("Um mapa da Câmara"),
        
	p("Pontos ideais estimados com base nas votações nominais da Reforma Politica. 
	  Este aplicativo está em versão betíssima."),
        
        hr(),
		  
	h4("Sobre a metodologia"),

     	p("Técnica de estimação bayesiana de pontos ideais compilada por Simon Jackman.
       	  PSCL R package. Função ideal()"),
      
	p("Atualizado até 27/05/2015."),
      
        hr(),

        p(a("Nossos dados", href = "")),

        img(src="necon.jpg", height = 67, width = 128),
        
        p("Conheça o", a("Necon.", href = "http://necon.iesp.uerj.br/"))

      )
      
  )
)					),
		   tabPanel("Líderanças"),
		   tabPanel("Votações")
		   ))