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
