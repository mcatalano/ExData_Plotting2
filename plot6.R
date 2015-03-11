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

## Subset data for Baltimore City and LA county by 'year'
balt_data <- vehicle_data[fips == '24510', Emissions, by = year]
la_data <- vehicle_data[fips == '06037', Emissions, by = year]

## Make new columns called "City"
balt_data$City <- "Baltimore City"
la_data$City <- "LA County"

## Combine city data
loc_data <- rbind(balt_data, la_data)

## Open graphics device
png(file = "plot6.png") 

## Plot with regression and differentiate cities by color
q <- qplot(year, Emissions, data = loc_data, col = City, geom = c('point', 'smooth'), 
           method = 'lm', xlab = 'Year', ylab = 'Tons of PM2.5', 
           main = 'Motor Vehicle-Related Emissions')

## Zoom in to see trend
q <- q + coord_cartesian(ylim = c(0,50))

## Scale x axis
q <- q + scale_x_continuous(breaks = c(1999,2002,2005,2008))

## Print plot
print(q)

## Close graphics device
dev.off()
