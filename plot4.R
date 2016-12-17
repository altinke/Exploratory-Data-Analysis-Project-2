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

## Read the Coal Combustion emission data per year
CoalCombustion <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE)
SCC.CoalCombustion <- SCC[CoalCombustion, ]$SCC
NEI.CoalCombustion <- NEI[NEI$SCC %in%  SCC.CoalCombustion, ]

pm25PerYear <- aggregate(NEI.CoalCombustion[c("Emissions")], list(year = NEI.CoalCombustion$year), sum)

## Draw the graph as a PNG
png("plot4.png")
ggplot(pm25PerYear, aes(factor(year), Emissions)) + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008')

dev.off()
