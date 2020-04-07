# Created by Noura Azeem
# April 6, 2020
# Plot 2 code
# Assignment 1 
# Exploratory Analysis


install.packages("data.table")
library("data.table")
library("dplyr")
setwd("~/datasciencecoursera/Exp_Analysis_4/data")

elec1 <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, dec=".")
subset <- elec1[elec1$Date %in% c("1/2/2007", "2/2/2007"),]

setwd("~/datasciencecoursera/Exp_Analysis_4")

# Plot 2
png("plot2.png", width= 480, height=480)
time2 <- strptime(paste(subset$Date, subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
plot(time2, elec2$Global_active_power, type="l", xlab= "", ylab="Global Active Power (kilowatts)")
dev.off()
