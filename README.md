# Rice Yield Prediction Shiny App

This Shiny app is designed to predict rice yield based on various input features such as annual rainfall, nitrogen content, potash content, phosphate content, and soil types.

## How to Use

1. Clone or download this repository to your local machine.

2. Ensure you have R and RStudio installed on your machine.

3. Open the RStudio project file (.Rproj) included in this repository.

4. Install the required R packages by running the following command in the R console:

5. Run the `app.R` script in RStudio.

6. The Shiny app will launch in your default web browser. Adjust the input sliders to set the values for the input features.

7. Click the "Predict" button to generate a prediction for rice yield based on the input values.

## Input Features

- **Annual**: Annual rainfall (mm)
- **Average Rainfall**: Average rainfall (mm)
- **Nitrogen**: Nitrogen content (kg/ha)
- **Potash**: Potash content (kg/ha)
- **Phosphate**: Phosphate content (kg/ha)
- **Inceptisols**: Percentage of Inceptisols in soil type
- **Loamy Alfisol**: Percentage of Loamy Alfisol in soil type
- **Orthids**: Percentage of Orthids in soil type
- **Psamments**: Percentage of Psamments in soil type
- **Sandy Alfisol**: Percentage of Sandy Alfisol in soil type
- **Udolls Udalfs**: Percentage of Udolls Udalfs in soil type
- **Udupts Udalfs**: Percentage of Udupts Udalfs in soil type
- **Ustalf Ustolls**: Percentage of Ustalf Ustolls in soil type
- **Vertic Soils**: Percentage of Vertic Soils in soil type
- **Vertisols**: Percentage of Vertisols in soil type
- **Rice Production**: Rice production (kg/ha)

## Notes

- This app provides a simple interface to predict rice yield based on the input features. The prediction model used in this app is for demonstration purposes only and may not be accurate for real-world applications.

- Feel free to explore and modify the code to suit your needs. For more information on customizing Shiny apps, refer to the [Shiny documentation](https://shiny.rstudio.com/).

- If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request on GitHub.

