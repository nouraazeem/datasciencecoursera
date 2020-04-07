# Created by Noura Azeem
# April 6, 2020
# Plot 4 code
# Assignment 1 
# Exploratory Analysis


install.packages("data.table")
library("data.table")
library("dplyr")
setwd("~/datasciencecoursera/Exp_Analysis_4/data")

elec1 <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, dec=".")
subset <- elec1[elec1$Date %in% c("1/2/2007", "2/2/2007"),]

setwd("~/datasciencecoursera/Exp_Analysis_4")

#Plot 4
png("plot4.png", width= 480, height=480)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma= c(0,0,2,0))

# Top left
plot(time2, subset$Global_active_power, type = "l", xlab = "", ylab= "Global Active Power", cex= 0.2)
# Top right
plot(time2, subset$Voltage, type = "l", xlab="datatime", ylab = "Voltage")
# Bottom left
plot(time2, as.numeric(subset$Sub_metering_1), type = "l", ylab = "Energy Submetering", xlab= "")
lines(time2, as.numeric(subset$Sub_metering_2), type = "l", col = "red")
lines(time2, as.numeric(subset$Sub_metering_3), type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2.5, col= c("black", "red", "blue"))
#Bottom right
plot(time2, subset$Global_active_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", cex = 0.2)
dev.off()
