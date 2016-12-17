## Make sure the plot library is loaded
library(ggplot2)

## Load data for plot
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Read the emission data per year
## Use only the Baltimore data (fips == 24510)
pm25PerYear <- aggregate(Emissions ~ type+year, NEI[NEI$fips=="24510",], sum)

## Draw the graph as a PNG
png("plot3.png")
ggplot(data = pm25PerYear, aes(x = year, y = Emissions, group = type, color = type)) +
  geom_line() +
  geom_point() +
  labs(title = "PM2.5 Emissions in City of Baltimore by Source Type")
dev.off()