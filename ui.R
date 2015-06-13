library(shiny)
library(shinythemes)
library(ggvis)


# Define the overall UI with a navbar
shinyUI(navbarPage("Reforma Política", theme = "sandstone.css",
		   
		   tabPanel("Alinhamento partidário",
		   	   # Use a fluid Bootstrap layout
  fluidPage(   
    
    # Generate a row 
    fluidRow(      
      
      # Create a spot for the tabs and plots
      mainPanel(
      	      	tabsetPanel(
      	  	tabPanel("Ideal", uiOutput("oideal_ui"), ggvisOutput("oideal")))),

      # Define the sidebar 
      sidebarPanel(
         h3("Alinhamento Partidário"),

         hr(),

        p("O gráfico representa a posição ideal estimada para cada partido. Passe o cursor sob
	  o nome para saber os valores em cada dimensão."),

        hr(),

	p(strong("Pontos ideais estimados com base nas votações nominais da Reforma Politica."), align = "center"),

        p(em("Este aplicativo está em versão beta."), align = "center"),

	p("Atualizado até 11/06/2015.", align = "center"),

        hr(),
		  
	h4("Sobre a metodologia"),

	p("As estimativas produzidas pelo NECON adotam o algoritmo IDEAL, 
	  implementado na linguagem R por Simon Jackman através do pacote pscl."),

	p("O posicionamento de cada partido no mapa vem do padrão das orientações de bancada. 
	  Em termos gerais, o algoritmo agrega todas as votações da reforma política, 
	  avalia quem orienta com quem, extrai as duas dimensões principais 
	  que explicam o padrão de votação e atribui uma pontuação para cada partido."),

        p("Saiba", a("mais.", href = "http://rpubs.com/jcanello/necon-ideal")),

        hr(),

        p(a("Nossos dados", href = "https://github.com/jcanello/reforma-politica/blob/master/data/partidos.csv")),

        img(src="necon.jpg", height = 67, width = 128),
        
        p("Conheça o", a("Necon.", href = "http://necon.iesp.uerj.br/"))

      )
      
  )
)
		   	 ),
		   
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

        hr(),

	p("O gráfico representa a posição ideal estimada para cada deputado. Passe o cursor sob
	  o ponto para saber nome, partido e estado do parlamentar."),

        hr(),

	p(strong("Pontos ideais estimados com base nas votações nominais da Reforma Politica."), align = "center"),

        p(em("Este aplicativo está em versão beta."), align = "center"),

	p("Atualizado até 11/06/2015.", align = "center"),

        hr(),
		  
	h4("Sobre a metodologia"),

	p("As estimativas produzidas pelo NECON adotam o algoritmo IDEAL, 
	  implementado na linguagem R por Simon Jackman através do pacote pscl."),

	p("O posicionamento de cada deputado no mapa vem do padrão das votações. Em termos gerais, 
	  o algoritmo agrega todas as votações  da reforma política, avalia quem vota com quem, extrai as duas dimensões principais 
	  que explicam o padrão de votação e atribui uma pontuação para cada parlamentar."),

        p("Saiba", a("mais.", href = "http://rpubs.com/jcanello/necon-ideal")),

        hr(),

        p(a("Nossos dados", href = "https://github.com/jcanello/reforma-politica/blob/master/data/camara.csv")),

        img(src="necon.jpg", height = 67, width = 128),

        p("Conheça o", a("Necon.", href = "http://necon.iesp.uerj.br/"))

      )
      
  )
)					),
		   
		   tabPanel("Votação por Votação")
		   ))