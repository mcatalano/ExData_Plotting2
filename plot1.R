## Load packages
library(data.table)

## Read data file; store as data table
NEI <- readRDS("summarySCC_PM25.rds")
DT <- data.table(NEI)

## Create data table containing sum of emissions arranged by 'year'
sums <- DT[, sum(Emissions), by = year]

## Open graphics device
png(file = "plot1.png")

## Plot with linear regression; 'V1' is sums column
with(sums, {
    
        plot(year, V1, type = 'p', pch = 19, main = 'Total Emissions', 
             xlab = 'Year', ylab = 'Tons of PM2.5')
        
        abline(lm(V1 ~ year), lwd = 2, col='blue')
})

## Close graphics device
dev.off()
