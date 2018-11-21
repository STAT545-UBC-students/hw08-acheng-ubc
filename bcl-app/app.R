library(shiny)
library(ggplot2)
library(dplyr)

bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel(
    div(
      img(height = 100, width = 900, src="BC_Liquor_Store_logo.png"),
      br(),
      "BC Liquor Store Prices")
    ),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, c(25, 40), pre = "$"),
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),
      uiOutput("countryOutput"),
      checkboxInput("pricesortInput", "Sort by Lowest Price")
    ),
    
    mainPanel(
      plotOutput("coolplot"),
      br(),
      textOutput("numResults"),
      br(),
      tableOutput("results")
    )
  )
)

server <- function(input, output) {
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })  
  
  output$numResults <- renderText({
    if (is.null(filtered())){
      "We found 0 items matching your selections :("
    } else {
      paste("We found ", nrow(filtered()), " items matching your selections.")
    }
  })

  
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }    
    
    res <- bcl %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
    
    if (nrow(res) == 0) {
      return(NULL)
    }
    
    if (input$pricesortInput) {
      return(res %>% arrange(Price))
    }
    
    return(res)
  })
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram()
  })

  output$results <- renderTable({
    if (is.null(filtered())) {
      return()
    }
    filtered()
  })
}

shinyApp(ui = ui, server = server)
