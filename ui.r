install.packages(setdiff(c("pacman"), rownames(installed.packages())))  

pacman::p_load(shiny, ggplot2, plotly,rAmCharts,colourpicker,gapminder,dplyr,highcharter,htmlwidgets,shinythemes,readxl)

shinyUI(
  
  navbarPage("Think Visual Think R",
             
             # tema 
             theme = bslib::bs_theme(bootswatch = "darkly"),
             
             # primeira tab -> Data
             tabPanel("Dados",
                      fileInput(inputId = "id_file", label = "Selecione um ficheiro .csv/.xlsx:",accept = c("text/csv",".xlsx",
                                                                                                            "text/comma-separated-values,text/plain",
                                                                                                            ".csv",
                                                                                                            '.xlsx'),
                                ),
                      navlistPanel(
                        widths = c(2, 10), 
                        tabPanel("Table", 
                                 h1("Dataset", style = "color : #0099ff;text-align:center"),
                                 # tabela
                                 dataTableOutput("table")),
                        tabPanel("Summary",verbatimTextOutput("summary"))
                      )
             ), 
             
             # segunda tab -> Visualizacao
             tabPanel("Visualizacao", 
                      #fileInput(inputId = "id_file1", label = "Seleciona um ficheiro .csv:"),
                      fluidRow(
                        # first column
                        column(width = 3, 
                               # wellPanel for grey background
                               wellPanel(
                                 sliderInput("bins",
                                             "Numero de bins:",
                                             min = 1,
                                             max = 50,
                                             value = 30),
                                 
                                 # input for color
                                 colourInput(inputId = "color", label = "Cor :", value = "purple"),
                                 
                                 # title
                                 textInput(inputId = "title", label = "Titulo :", value = "Coloca aqui o titulo para o teu grafico"),
                                 
                                 # variable choice
                                 radioButtons(inputId = "var1", label = "Variavel X :", choices = c("Item A", "Item B", "Item C")),
                                 
                                 radioButtons(inputId = "var2", label = "Variavel Y : ", choices = c("Item A", "Item B", "Item C")),
                                 
                                 radioButtons(inputId = "var3", label = "Variavel Z : ", choices = c("Item A", "Item B", "Item C"))
                               )
                        ), 
                        # second column
                        column(width = 9, 
                               tabsetPanel(id = "viz",
                                           
                                           tabPanel("Histograma", 
                                                    plotOutput("hist")
                                           ),
                                           tabPanel("Boxplot", 
                                                    amChartsOutput("boxplot")
                                           ),
                                           
                                           tabPanel("Diagrama de caixas com bigodes",
                                             plotOutput("boxplot2")
                                           ),
                                           
                                           tabPanel("Grafico de barras",
                                             plotlyOutput("barras")
                                           ),
                                           
                                           tabPanel("Grafico de Densidade",
                                             plotOutput("densidade")
                                           ),
                                           
                                           tabPanel("Diagrama de dispersao",
                                             plotOutput("grafico")
                                           ),
                                           
                                           tabPanel("Diagrama de dispersao (agrupando os dados em grupos da variavel z)",
                                              plotlyOutput("plot")
                                           ),
                                           
                                           tabPanel("Grafico de series temporais",
                                             plotlyOutput("pltly")
                                           ),
                                           
                                           tabPanel("Grafico Dinamico",
                                             plotlyOutput("animated_plot"),
                                             actionButton("anim", "Animate")
                                           )
                               )
                        )
                      )
             ),
             # terceira tab -> Sobre
             tabPanel("Sobre",
                        titlePanel("A nossa aplicacao shiny"),
                        p("Foi construida uma aplicacao shiny,para analise de dados, que permite que o utilizador faca o upload de um ficheiro de dados no formato retangular (.csv, xlsx com linhas: casos,colunas: dimensoes) e selecione as colunas com que quer trabalhar.",style = "font-family: 'times'; font-si16pt"),
                        p("Sao desenvolvidos varios graficos, podendo o utilizador depois escolher aquele que mais se adequa as suas necessidades, entre eles temos:",style = "font-family: 'times'; font-si16pt"),
                        p("- Tabelas e graficos de barras para dados categoricos.",style = "font-family: 'times'; font-si16pt"),
                        p("- Histogramas, graficos de densidade, diagramas de caixas com bigodes para as colunas com dados em escala continua.",style = "font-family: 'times'; font-si16pt"),
                        p("- Diagramas de dispersao para duas colunas de dados em escala continua, com curvas loess",style = "font-family: 'times'; font-si16pt"),
                        p("- Graficos de series temporais se uma das colunas e relativa a tempo",style = "font-family: 'times'; font-si16pt"),
                        p("- Tabelas com estatisticas sumarias dos dados: min, max quartis, media, desvio padrao.",style = "font-family: 'times'; font-si16pt")

                     ),
             # quarta tab -> Autoria
             tabPanel("Autoria",
                      p("App desenvolvida no ambito da UC Projeto de LCC por:"),
                      p("- Hugo Costeira a87976,"),
                      p("- Joao Diogo Silva a87939,"),
                      p("- Joao Gouveia a87995,"),
                      p("- Pedro Martins a87964"),
                      tags$h1("Codigo fonte"),
                      tags$a(href="https://github.com/JDS26/Proj_Final_LCC", 
                             "Pagina do Github"),
             )
    )
)