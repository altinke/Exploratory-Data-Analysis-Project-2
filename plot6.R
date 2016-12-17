## Compare emissions from motor vehicle sources in Baltimore City (fips == "24510")
## with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?

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

## Read the emission data of motor vehicle sources in Baltimore City and Los Angeles per year
## Baltimore City: fips == "24510"
## Los Angeles County: fips = "06037"
## Motor Vehicle sources: type = "ON-ROAD"
pm25PerYear <- aggregate(Emissions ~ year + fips, NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ], sum)
pm25PerYear <- transform(pm25PerYear,
                               region = ifelse(pm25PerYear$fips == "24510", "Baltimore City", "Los Angeles County"))

## Draw the graph as a PNG
png("plot6.png")
ggplot(pm25PerYear, aes(factor(year), Emissions)) + 
  facet_grid(. ~ region) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicles in Baltimore City and Los Angeles from 1999 to 2008')

dev.off()
