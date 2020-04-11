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

# Question 1 ----
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the 
# years 1999, 2002, 2005, and 2008.
setwd("/Users/nouraazeem/datasciencecoursera/Exp_Analysis_4")
PM25.by.year <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png", width= 480, height=480)
plot(names(PM25.by.year), PM25.by.year, type = "l",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()

# Total emissions have been decreasing in the United States from 1999 to 2008

# Question 2 ----
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#fips == "24510" from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

balt <- subset(NEI, NEI$fips == "24510")

baltimore <- aggregate(Emissions ~ year, balt, sum)

png("plot2.png")
plot(baltimore$year, baltimore$Emissions, type = "l", 
     main = expression("Total Baltimore" ~ PM[2.5] ~ "Emissions by Year"), xlab = "Year", 
     ylab = expression("Total Baltimore "~ PM[2.5] ~ "Emissions"), col = "blue")
dev.off()

# Yes, The PM2.5 emissions have also decreased in Baltimore, MD

# Question 3 ----
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

balt <- subset(NEI, NEI$fips == "24510")

png("plot3.png")
ggplot(balt,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(.~type) + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()

# of the four types of sources (non-road, nonpoint, on-road, point) the sources that have decreased in emissions from 
# 1999 - 2008 for Baltimore:
# Sources that saw decreases in Emissions were non-road, non-point, on-road
# point saw an increase from 2005 - 2008, but then there was a decrease from 2005 - 2008

# Question 4 ----
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

SCCcoal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC,]
totalCoal <- aggregate(Emissions ~ year + type, NEIcoal, sum)

png("plot4.png", width= 480, height=480)
ggplot(totalCoal, aes(year, Emissions, col = type)) +
  geom_line() +
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emission by Type and Year")) +
  xlab("Year") +
  ylab(expression("US " ~ PM[2.5] ~ "Coal Emission")) +
  scale_colour_discrete(name = "Type of sources") +
  theme(legend.title = element_text(face = "bold"))
dev.off()
# Coal combustion-related sources have decreased from 1999-2008 

# Question 5 ----
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

baltMotor <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
baltMotorAGG <- aggregate(Emissions ~ year, baltMotor, sum)

png("plot5.png", width= 480, height=480)
ggplot(baltMotorAGG, aes(year, Emissions)) +
  geom_line(col = "red") +
  ggtitle(expression("Baltimore " ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") +
  ylab(expression(~PM[2.5]~ "Motor Vehicle Emissions"))
dev.off()
# Emissions from moter vehicles have decreased from 1998-2008

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



