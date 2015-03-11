## Load packages
library(data.table)
library(ggplot2)

## Read data files; store NEI as data table
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
DT <- data.table(NEI)

## Retrieve SCC codes for entries with 'coal' in 'Short.Name'
SCC_codes <- SCC[grep('[cC]oal', SCC$Short.Name), 'SCC']

## Subset data from NEI with SCC equal to character in SCC_codes list
coal_data <- DT[SCC == as.character(SCC_codes), ]

## Open graphics device
png(file = "plot4.png") 

## Bar plot showing total emissions and individual data points as color.
q <- qplot(year, Emissions, data = coal_data, geom = 'bar', stat = 'identity',
           fill = Emissions, xlab = 'Year', ylab = 'Total Tons of PM2.5', 
           main = 'Coal-Related Emissions')

## Scale x axis
q <- q + scale_x_continuous(breaks = c(1999,2002,2005,2008))

## Print plot
print(q)

## Close graphics device
dev.off()
