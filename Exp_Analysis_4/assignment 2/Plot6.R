# Exp_Analysis
# Project 2
# BY: Noura Azeem
# Date: April 11

# The overall goal of this assignment is to explore the National Emissions Inventory database 
# and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. 
#You may use any R package you want to support your analysis.

#Questions
# You must address the following questions and tasks in your exploratory analysis. 
# For each question/task you will need to make a single plot. Unless specified, 
# you can use any plotting system in R to make your plot.
library("ggplot2")

setwd("/Users/nouraazeem/datasciencecoursera/Exp_Analysis_4/data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 6 ----
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California fips == "06037"
# Which city has seen greater changes over time in motor vehicle emissions?


baltLAMotors <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")
baltLAMotorsAGG <- aggregate(Emissions ~ year + fips, baltLAMotors, sum)

BaltimoreNEI <- baltLAMotors[baltLAMotors$fips == 24510,]
BaltimoreNEI$city <- "Baltimore City"
LANEI <- baltLAMotors[baltLAMotors$fips=="06037",]
LANEI$city <- "Los Angeles County"
bothNEI <- rbind(BaltimoreNEI,LANEI)

png("plot6.png", width= 480, height=480)
ggplot(bothNEI, aes(year, Emissions, fill = city)) +
  geom_bar(aes(fill=year), stat = "identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
dev.off()

# LA has had more change over time and though they are seeing a decrease from 2005- 2008, the 2008 value is still more
# than the initial total emissions in 1999

