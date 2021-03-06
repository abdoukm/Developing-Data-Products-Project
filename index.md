---
title       : San Francisco International Airport (SFO) Passenger Traffic Explorer
author      : Khaled Abdou
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction 

- San Francisco International Airport makes available historical monthly passenger traffic volumes

- Data items avaiable include are Arilines, Region of origin or destination, direction ( Arrival or Deparature)  

- The Data is available from JUly 2005 through June 2015


---

## Application Description

The application explores historical monthly passengers volumes that pass through SFO from  7/2015 Through end 6/2015

User can select or change: 

1. The from/to period of interest
2. The airlines of interest
3. The regions from/to the passengers were traveling 
4. The Activities of the passengers ( Enplaned = Departure, Deplaned = Arrival, Thru/Transit = Transit)

The application is hosted at the link listed below:
https://abdoukm.shinyapps.io/Project

--- .class #id 

## Application Layout


The tool has an input panel with:

A date range selection slider

A passenger activity selection group of check boxes

A region selection group of check boxes

An airlines selection group of check boxes


The tool has 2 output tabs  
 - The data grid dispalying the filtreed result set based on the user settings in teh input panel
 - 2 Graphical Plots
 
The tool hides ui.R and server.R code from user view. 

--- .class #id 

As the application requires a data file to read and disaply data, 
the following will demostrate embedded r code in this document 
## Farenheit-Celsius Calculation





```r
Farenheit = (Celsius * (9/5)) + 32


Celsius = (Farenheit - 32) * (5/9)
```

For example to caclulate the temperature in Farenheit when the temperature in Celsius is 17 degrees. 

```r
Celsius<-17
Farenheit = (Celsius * (9/5)) + 32
Farenheit
```

```
## [1] 62.6
```


