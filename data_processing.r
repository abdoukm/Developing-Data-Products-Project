#setwd("G:/Users/abdoukm/GoogleDrive/Google Drive/Courses/Coursera/Data Science Specialization/Developing Data Products/Project")
# Load required libraries
require(data.table)
library(zoo)
library(dplyr)
library(DT)
library(rCharts)

# Read data
data <- fread("./MonthlyPassengerData_200507_to_201506.csv")
setnames(data, "GEO Region", "Region")
setnames(data, "Activity Type Code", "Activity")
setnames(data, "Passenger Count", "Traffic")
setnames(data, "Activity Period", "YearMonth")
setnames(data, "Operating Airline", "Carrier")
sum(is.na(data)) # 0
length(unique(data$YearMonth)) # 13901
length(table(data$YearMonth)) # 64
years <-  sort(unique(substr(data$YearMonth,1,4)))
monthes <-  sort(unique(substr(data$YearMonth,5,6)))
regions <- sort(unique(data$Region))
length(table(data$Carrier)) # 102
airlines <- sort(unique(data$Carrier))


## Data Helper Calls

# Filter dataset by Date Range, Regions, Airlines and Activities
# 
#
applyFilters <- function(dt, minYearMonth, maxYearMonth, minTraffic,
                             maxTraffic, regions,activities,airlines) {
    result <- dt %>% filter(as.Date(as.yearmon(as.character(YearMonth), "%Y%m"), frac = 1) >= minYearMonth, as.Date(as.yearmon(as.character(YearMonth), "%Y%m"), frac = 1) <= maxYearMonth,
                            Traffic >= minTraffic, Traffic <= maxTraffic,
                            Region %in% regions, Activity %in% activities, Carrier %in% airlines) 
    return(result)
}


# Group filter dataset by Date Range, Regions, Airlines and Activities then calculate total by Region
# 

 groupByRegion <- function(dt, minYearMonth, maxYearMonth, minTraffic, maxTraffic, regions,activities,airlines) {
                dt <- applyFilters (dt, minYearMonth, maxYearMonth, minTraffic, maxTraffic, regions,activities,airlines)
                result <- dt %>% 
                      group_by(Region) %>%
                      summarise(total_traffic = sum(Traffic)) %>%
                      arrange(Region)
              
              return(result)         
                  
 }

 # Group filter dataset by Date Range, Regions, Airlines and Activities then calculate total by Airline
 # 
 
 groupByAirline <- function(dt, minYearMonth, maxYearMonth, minTraffic, maxTraffic, regions,activities,airlines) {
         dt <- applyFilters (dt, minYearMonth, maxYearMonth, minTraffic, maxTraffic, regions,activities,airlines)
         result <- dt %>% 
                 group_by(Carrier) %>%
                 summarise(total_traffic = sum(Traffic)) %>%
                 arrange(Carrier)
         
         return(result)         
         
 } 

 ## Plotting Helper Calls
 
 
plotTrafficByRegion <- function(dt, dom = "trafficByRegionTotal", 
                                                                 xAxisLabel = "Regions", 
                                                                 yAxisLabel = "Total Traffic") {
                                    trafficByRegionTotal <- nPlot(
                                        total_traffic ~ Region,
                                        data = dt,
                                        type = "multiBarChart",
                                        dom = dom, width = 650
                                    )
                                    trafficByRegionTotal$chart(margin = list(left = 100))
                                    trafficByRegionTotal$chart(color = c('pink', 'blue', 'green'))
                                    trafficByRegionTotal$yAxis(axisLabel = yAxisLabel, width = 80)
                                    trafficByRegionTotal$xAxis(axisLabel = xAxisLabel, width = 200,
                                                           rotateLabels = -20, height = 200)
                                    trafficByRegionTotal
 
 
}

 
 plotTrafficByAirline <- function(dt, dom = "trafficByAirlineTotal", 
                                 xAxisLabel = "Airlines", 
                                 yAxisLabel = "Total Traffic") {
         trafficByAirlineTotal <- nPlot(
                 total_traffic ~ Carrier,
                 data = dt,
                 type = "multiBarChart",
                 dom = dom, width = 650
         )
         trafficByAirlineTotal$chart(margin = list(left = 100))
         trafficByAirlineTotal$chart(color = c('pink', 'blue', 'green'))
         trafficByAirlineTotal$yAxis(axisLabel = yAxisLabel, width = 80)
         trafficByAirlineTotal$xAxis(axisLabel = xAxisLabel, width = 200,
                                    rotateLabels = -20, height = 200)
         trafficByAirlineTotal
         
         
 }
 
