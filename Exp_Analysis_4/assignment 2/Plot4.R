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
