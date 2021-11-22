library(data.table)
library(randomForest)

# Read in the RF model
model <- readRDS("model.rds")

shinyServer(function(input, output, session) {
  
  # Input Data
  datasetInput <- reactive({  
    
    df <- data.frame(
      Name = c("habitat",
               "população",
               "cor.esporo",
               "tipo.anel"),
      Value = as.character(c(input$habitat,
                             input$população,
                             input$cor.esporo,
                             input$tipo.anel)),
      stringsAsFactors = FALSE)
    
    classe <- 0
    df <- rbind(df, classe)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    
    Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)
    
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Cálculo completo.") 
    } else {
      return("Servidor pronto para realizar o cálculo.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
})
