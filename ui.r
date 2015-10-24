# The user-interface definition of the Shiny web app.
library(shiny)
library(zoo)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
    navbarPage(" San Francisco International Airport (SFO) Passenger Traffic ", 
    # multi-page user-interface that includes a navigation bar.
        tabPanel("Explore the Data",
             sidebarPanel(
                sliderInput("timeline", 
                            "Time :", timeFormat = "%F",
                            min = as.Date('2007-07-01') ,
                            max = as.Date('2015-06-30'),
                            step = 1,
                            value = c(as.Date('2010-01-31'), as.Date('2011-06-30'))),
                sliderInput("traffic", 
                            "Monthly Number of Passengers:",
                            min = 0,
                            max = 600000,
                            step = 10,
                            value = c(100000, 1000000) 
                ),

                uiOutput("regionsControl"), 
                actionButton(inputId = "clearAllRegions", 
                             label = "Clear region selection", 
                             icon = icon("square-o")),
                actionButton(inputId = "selectAllRegions", 
                             label = "Select all regions", 
                             icon = icon("check-square-o")),

                uiOutput("activitiesControl"),
                actionButton(inputId = "clearAllActivities", 
                             label = "Clear activity selection", 
                             icon = icon("square-o")),
                actionButton(inputId = "selectAllActivities", 
                             label = "Select all activities", 
                             icon = icon("check-square-o")),
                
                uiOutput("airlinesControl"), 
                actionButton(inputId = "clearAllAirlines", 
                             label = "Clear airline selection", 
                             icon = icon("square-o")),
                actionButton(inputId = "selectAllAirlines", 
                             label = "Select all airline", 
                             icon = icon("check-square-o"))
                
                        
             ),
             mainPanel(
                 tabsetPanel(
                   # Data 
                   tabPanel(p(icon("table"), "Dataset"),
                            dataTableOutput(outputId="dTable")
                   ), # end of "Dataset" tab panel,
                    tabPanel(p(icon("line-chart"), "Data Visualization"),
                             h5('Hover over each point to see the Total Traffic.', 
                                align ="center"),
                             h4('Traffic by Region', align = "center"),
                             showOutput("trafficByRegionTotal", "nvd3"),
                             h4('Traffic by Airline', align = "center"),
                             showOutput("trafficByAirlineTotal", "nvd3")
                             
                    ) # end of "Data Visualization" tab panel

                 )
                   
            )     
        ), # end of "Explore the Data" tab panel
    
       
        tabPanel("About & How to Use",
                 mainPanel(
                   includeMarkdown("about.md")
                 )
        ) # end of "About" tab panel
    )
  
)