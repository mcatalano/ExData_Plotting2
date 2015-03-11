## Load packages
library(data.table)
library(ggplot2)

## Read data files; store NEI as data table
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
DT <- data.table(NEI)

## Subset data table by 'ON-ROAD' emissions only
road_data <- DT[type == 'ON-ROAD', ]

## Retrieve SCC codes for entries with 'vehicle' in 'Short.Name'
SCC_codes <- SCC[grep('[vV]ehicle', SCC$Short.Name), 'SCC']

## Subset rows of data table where SCC equals a character in SCC_codes 
vehicle_data <- road_data[SCC == as.character(SCC_codes), ]

## Subset data for Baltimore City by 'year'
balt_data <- vehicle_data[fips == '24510', Emissions, by = year]

## Open graphics device
png(file = "plot5.png") 

## Plot with linear regression line
q <- qplot(year, Emissions, data = balt_data, geom = c('point','smooth'), method = 'lm', xlab = 'Year',
      ylab = 'Tons of PM2.5', main = 'Motor Vehicle-Related Emissions in Baltimore City')

## Print plot
print(q)

## Close graphics device
dev.off()
