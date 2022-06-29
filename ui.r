library(shiny)
library(rAmCharts)
library(colourpicker)
library(ggplot2)
library(plotly)
library(gapminder)
library(dplyr)
library(highcharter)
library(htmlwidgets)
library(shinythemes)
# Define UI for application that draws a histogram
shinyUI(
  # navbarPage
  navbarPage("Think Visual Think R",
             
             # theme 
             theme = bslib::bs_theme(bootswatch = "darkly"),
             
             #uiOutput("tab"),
             
             # First tab Data
             tabPanel("Data",
                      fileInput(inputId = "id_file", label = "Seleciona um ficheiro .csv:"),
                      navlistPanel(
                        widths = c(2, 10), 
                        tabPanel("Table", 
                                 # title with css
                                 h1("Dataset", style = "color : #0099ff;text-align:center"),
                                 # table
                                 dataTableOutput("table")),
                        tabPanel("Summary",verbatimTextOutput("summary"))
                      )
             ), 
             
             # second tab Visualization
             tabPanel("Visualization", 
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
                                 textInput(inputId = "title", label = "Titulo :", value = "Histogram"),
                                 
                                 # variable choice
                                 radioButtons(inputId = "var1", label = "Variavel X:", choices = c("Item A", "Item B", "Item C")),
                                 
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
                                           
                                           tabPanel("BoxPlot_v2",
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
                                           
                                           tabPanel("Diagrama de dispersao_v2 (agrupando os dados em grupos da variavel z)",
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
             
             tabPanel("Sobre",p("p creates a paragraph of text."),
                     ),
             tabPanel("Autoria", p("App desenvolvida no ambito da UC Projeto de LCC por:"),
                      p("- Hugo Costeira a87971,"),
                      p("- Joao Diogo Silva a87939,"),
                      p("- Joao Pedro Gouveia a87,"),
                      p("- Pedro Martins a87"),
                      tags$h1("Codigo fonte"),
                      tags$a(href="https://github.com/JDS26/Proj_Final_LCC", 
                             "Pagina do Github"),
             )
    )
)