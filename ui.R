library(shiny)

# Training set
TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

pageWithSidebar(
  
  # Page header
  headerPanel('MushroomRClassification'),
  
  # Input values
  sidebarPanel(
    HTML("<h3>Entre com os parâmetros a sua escolha</h4>"),
    selectInput("habitat","Escolha o habitat", choices =c("madeiras", "graminea", "folhas", "prados", "caminhos", "urbano", "residuos")),
    selectInput("população","Escolha a população", choices =c("abundante", "aglomerado", "numeroso", "espalhado", "varias", "solitario")),
    selectInput("cor.esporo", "Escolha a cor do esporo", choices =c("amarelado", "chocolate", "preto", "marrom", "laranja", "verde", "roxo", "branco", "amarelo")),
    selectInput("tipo.anel", "Escolha o tipo do anel", choices =c("evanescente", "flamejante", "largo", "nenhum", "pendente", "teia de aranha", "bainha", "zona")),
    
    actionButton("submitbutton", "Submit", class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table
    
  )
)