## Make sure the plot library is loaded
library(ggplot2)

## Load data for plot
## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Read the emission data of motor vehicle sources in Baltimore City per year
## Baltimore City: fips = "24510"
## Motor Vehicle sources: type = "ON-ROAD"
pm25PerYear <- aggregate(Emissions ~ year, NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ], sum)

## Draw the graph as a PNG
png("plot5.png")
ggplot(pm25PerYear, aes(factor(year), Emissions)) + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicles in Baltimore City from 1999 to 2008')

dev.off()
