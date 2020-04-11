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
