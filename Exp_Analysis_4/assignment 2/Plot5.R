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
