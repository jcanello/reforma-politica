library(shiny)
library(shinythemes)
library(ggvis)
library(rCharts)

# Define the overall UI with a navbar
shinyUI(navbarPage(
	"Reforma Política", theme = "sandstone.css",
		   tabPanel("Votações",
		   	 	fluidPage(fluidRow(
		   	 		
		   	 		# Define the sidebar 
					   sidebarPanel(
					        h3("Votações"),
					
					        hr(),
					
						p("O gráfico mostra a divisão dos partidos nas votações da Reforma Política
						  (PEC 182/2007) na Câmara dos Deputados em primeiro turno. Passe o cursor para ver como os partidos votaram. Você pode selecionar as categorias de interesse (sim, não, etc) e forma
						  de apresentação do gráfico."),
					
					        hr(),
					        
					        p(em("Este aplicativo está em versão beta."), align = "center"),
					
						p("Siglas com menos de 8 deputados foram omitidas.", align = "center"),
					
					        hr(),
					
					        selectInput(inputId = "vote",
					      		label = "Votação",
					      		choices = unique(as.character(tots$item)),
					      		),
					  
					        p(a("Nossos dados", href = "https://github.com/jcanello/reforma-politica/blob/master/data/tots.csv")),
					
					        img(src="necon.jpg", height = 60.3, width = 115.2),
					
					        p("Conheça o", a("Necon.", href = "http://necon.iesp.uerj.br/"))
					
					      ),
		    
			      # Create a spot for the tabs and plots
				      mainPanel(showOutput("chart1", "nvd3")  	
						)
 
		   	 			)	)
			
			   ),
	
  		tabPanel("Alinhamento partidário", 
  			 	fluidPage(fluidRow(
  			 		# Define the sidebar 
					   sidebarPanel(
					        h3("Alinhamento Partidário"),
					
					        hr(),
					
					        p("O gráfico representa a posição ideal estimada para cada partido. Passe o cursor sob
						  o nome para saber os valores em cada dimensão."),
					
					        hr(),
					
						p(strong("Pontos ideais estimados com base nas votações nominais da Reforma Politica."), align = "center"),
					
					        p(em("Este aplicativo está em versão beta."), align = "center"),
					
						p("Atualizado até 17/06/2015.", align = "center"),
					
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

							),
    	
   					# Create a spot for the tabs and plots
   					mainPanel(uiOutput("oideal_ui"), ggvisOutput("oideal")
      	      					  )
          				)	)
		   	 ),
		   
  		tabPanel("Mapa dos Deputados", 
  			 	fluidPage(fluidRow(      
					# Define the sidebar 
		    			  sidebarPanel(
					        h3("Um mapa da Câmara"),
					
					        hr(),
					
						p("O gráfico representa a posição ideal estimada para cada deputado. Passe o cursor sob
						  o ponto para saber nome, partido e estado do parlamentar."),
					
					        hr(),
					
						p(strong("Pontos ideais estimados com base nas votações nominais da Reforma Politica."), align = "center"),
					
					        p(em("Este aplicativo está em versão beta."), align = "center"),
					
						p("Atualizado até 17/06/2015.", align = "center"),
					
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
					
					      ),
		      
		      
					# Create a spot for the tabs and plots
					    mainPanel(uiOutput("ideal_ui"), ggvisOutput("ideal")
					   	       )
					)))
	
		)
	)