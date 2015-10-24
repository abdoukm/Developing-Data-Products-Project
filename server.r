library(shiny)
library(zoo)
# Source data processing file
source("data_processing.r")

regions <- sort(unique(data$Region))
airlines <- sort(unique(data$Carrier))
activities <- sort(unique(data$Activity))

# Shiny server

shinyServer(
   function(input, output) {

    # Initialize reactive values
    values <- reactiveValues()
    values$regions <- regions
    values$activities <- activities
    values$airlines <- airlines
    
    # Create event type checkbox
    output$regionsControl <- renderUI({
        checkboxGroupInput('regions', 'Regions:', 
                           regions, selected = values$regions, inline = TRUE)
    })
    
    # Add observer on select-all button
    observe({
        if(input$selectAllRegions == 0) return()
        values$regions <- regions
    })
    
    # Add observer on clear-all button
    observe({
        if(input$clearAllRegions == 0) return()
        values$regions <- c() # empty list
    })

    # Create event type checkbox
    output$activitiesControl <- renderUI({
            checkboxGroupInput('activities', 'Activities:', 
                               activities, selected = values$activities, inline = TRUE)
    })
    
    # Add observer on select-all button
    observe({
            if(input$selectAllActivities == 0) return()
            values$activities <- activities
    })
    
    # Add observer on clear-all button
    observe({
            if(input$clearAllActivities == 0) return()
            values$activities <- c() # empty list
    })
    
        
    # Create event type checkbox
    output$airlinesControl <- renderUI({
            checkboxGroupInput('airlines', 'Airlines:', 
                               airlines, selected = values$airlines,inline = TRUE)
    })
    
    # Add observer on select-all button
    observe({
            if(input$selectAllAirlines == 0) return()
            values$airlines <- airlines
    })
    
    # Add observer on clear-all button
    observe({
            if(input$clearAllAirlines == 0) return()
            values$airlines <- c() # empty list
    })    

    # Prepare dataset
    dataTable <- reactive({
            applyFilters(data, as.Date(as.character(input$timeline[1]), format='%Y-%m-%d'), 
                         as.Date(as.character(input$timeline[2]), format='%Y-%m-%d'), input$traffic[1],
                     input$traffic[2], input$regions, input$activities, input$airlines)
     })
 
    
    dataTableByRegion <- reactive({
            groupByRegion(data, as.Date(as.character(input$timeline[1]), format='%Y-%m-%d'), 
                         as.Date(as.character(input$timeline[2]), format='%Y-%m-%d'), input$traffic[1],
                         input$traffic[2], input$regions, input$activities, input$airlines)
    })

    dataTableByAirline <- reactive({
            groupByAirline(data, as.Date(as.character(input$timeline[1]), format='%Y-%m-%d'), 
                          as.Date(as.character(input$timeline[2]), format='%Y-%m-%d'), input$traffic[1],
                          input$traffic[2], input$regions, input$activities, input$airlines)
    })
    
    

    
    # Render data table
    output$dTable <- renderDataTable({
        dataTable()
    })
    
     output$trafficByRegionTotal <- renderChart({
             plotTrafficByRegion(dataTableByRegion())
     })

     output$trafficByAirlineTotal <- renderChart({
             plotTrafficByAirline(dataTableByAirline())
     })
     
   
  } # end of function(input, output)
)