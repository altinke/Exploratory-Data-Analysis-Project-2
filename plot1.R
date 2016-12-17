## Load data for plot
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Read the emission data per year
pm25PerYear <- aggregate(Emissions ~ year, NEI, sum)

## Draw the graph as a PNG
png("plot1.png")
plot(pm25PerYear$year, pm25PerYear$Emissions, type = "l", 
     main = "Total Emissions from PM2.5 in the US",
     xlab = "Year", ylab = "Emissions")
dev.off()