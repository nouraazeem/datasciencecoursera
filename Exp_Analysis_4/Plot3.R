# Created by Noura Azeem
# April 6, 2020
# Plot 3 code
# Assignment 1 
# Exploratory Analysis


install.packages("data.table")
library("data.table")
library("dplyr")
setwd("~/datasciencecoursera/Exp_Analysis_4/data")

elec1 <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, dec=".")
subset <- elec1[elec1$Date %in% c("1/2/2007", "2/2/2007"),]

setwd("~/datasciencecoursera/Exp_Analysis_4")

#Plot 3
png("plot3.png", width= 480, height=480)
plot(time2, as.numeric(subset$Sub_metering_1), type = "l", ylab = "Energy Submetering", xlab= "")
lines(time2, as.numeric(subset$Sub_metering_2), type = "l", col = "red")
lines(time2, as.numeric(subset$Sub_metering_3), type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col= c("black", "red", "blue"))
dev.off()
