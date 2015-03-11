## Load packages
library(data.table)
library(ggplot2)

## Read data file; store as data table
NEI <- readRDS("summarySCC_PM25.rds")
DT <- data.table(NEI)

## Create data table containing Baltimore City ('24510') emissions arranged by 'type' and 'year'
balt_data <- DT[fips == '24510', Emissions, by = c('type', 'year')] 

## Open graphics device
png(file = "plot3.png") 

## Plot including linear regression to show trend over 1999-2008 for each emissions 'type'
q <- qplot(year, Emissions, data = balt_data, facets = . ~ type,
      main = 'Baltimore City Total Emissions', xlab = 'Year', ylab = 'Tons of PM2.5',
      geom = c('point','smooth'), method = 'lm')

## Make x-axis labesl vertical and print plot
q <- q + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0))

## Zoom in to see trends
q <- q + coord_cartesian(ylim = c(0,75))

## Print plot
print(q)

## Close graphics device
dev.off()
