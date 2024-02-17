library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Rice Yield Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      # Input fields for the features
      fluidRow(
        column(6,
               numericInput("ANNUAL", "Annual", value = 1103.9)
        ),
        column(6,
               numericInput("avg_rain", "Average Rainfall", value = 62.53333)
        )
      ),
      fluidRow(
        column(6,
               numericInput("Nitrogen", "Nitrogen", value = 52888)
        ),
        column(6,
               numericInput("POTASH", "Potash", value = 10466)
        )
      ),
      fluidRow(
        column(6,
               numericInput("PHOSPHATE", "Phosphate", value = 23912)
        ),
        column(6,
               numericInput("INCEPTISOLS", "Inceptisols", value = 0)
        )
      ),
      fluidRow(
        column(6,
               numericInput("LOAMY_ALFISOL", "Loamy Alfisol", value = 0.6)
        ),
        column(6,
               numericInput("ORTHIDS", "Orthids", value = 0)
        )
      ),
      fluidRow(
        column(6,
               numericInput("PSAMMENTS", "Psamments", value = 0)
        ),
        column(6,
               numericInput("SANDY_ALFISOL", "Sandy Alfisol", value = 0)
        )
      ),
      fluidRow(
        column(6,
               numericInput("UDOLLS_UDALFS", "Udolls Udalfs", value = 0)
        ),
        column(6,
               numericInput("UDUPTS_UDALFS", "Udupts Udalfs", value = 0)
        )
      ),
      fluidRow(
        column(6,
               numericInput("USTALF_USTOLLS", "Ustalf Ustolls", value = 0.4)
        ),
        column(6,
               numericInput("VERTIC_SOILS", "Vertic Soils", value = 0)
        )
      ),
      fluidRow(
        column(6,
               numericInput("VERTISOLS", "Vertisols", value = 0)
        ),
        column(6,
               numericInput("RICE_PRODUCTION", "Rice Production", value = 984.3)
        )
      ),
      
      actionButton("predictButton", "Predict")
    ),
    
    mainPanel(
      # Display the prediction result
      h3("Predicted Rice Yield:"),
      verbatimTextOutput("prediction")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Function to make predictions
  predict_yield <- function(input_data) {
    # Convert input data to data frame
    new_data <- data.frame(t(input_data))
    
    # Make predictions here using your model
    # For example, prediction <- predict(model, newdata = new_data)
    
    # Dummy prediction for demonstration purposes
    prediction <- sum(input_data)
    
    return(prediction)
  }
  
  # React to button click to make predictions
  observeEvent(input$predictButton, {
    # Gather input data
    input_data <- c(
      input$ANNUAL, input$avg_rain, input$Nitrogen, input$POTASH, 
      input$PHOSPHATE, input$INCEPTISOLS, input$LOAMY_ALFISOL, input$ORTHIDS,
      input$PSAMMENTS, input$SANDY_ALFISOL, input$UDOLLS_UDALFS, 
      input$UDUPTS_UDALFS, input$USTALF_USTOLLS, input$VERTIC_SOILS, 
      input$VERTISOLS, input$RICE_PRODUCTION
    )
    
    # Call the predict_yield function with input values
    predicted_yield <- predict_yield(input_data)
    
    # Update the output with the predicted yield
    output$prediction <- renderText({
      predicted_yield
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)
