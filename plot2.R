## Load data for plot
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Read the emission data per year
## Use only the Baltimore data (fips == 24510)
pm25PerYear <- aggregate(Emissions ~ year, NEI[NEI$fips=="24510",], sum)

## Draw the graph as a PNG
png("plot2.png")
plot(pm25PerYear$year, pm25PerYear$Emissions, type = "l", 
     main = "Total Emissions from PM2.5 in Baltimore City",
     xlab = "Year", ylab = "Emissions")
dev.off()