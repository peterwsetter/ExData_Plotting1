# Author: Peter W Setter
# R file documenting the creation of plot3.png for Exploratory
# Data Analysis Course Project 1

# Input: This R script reads a subset covering 2007 Jan 1 & 2007 Jan 2
# of the Household Power Consumption data set
# from the UC Irvine Machine Learning Repository

# Output: plots the three submeters vs. time and saves the figure
# as plot3.png

library(data.table)

# Calculate the number of data points over the two days
rowsToRead <- 2*24*60

# Read using fread
# skip = "1/2/2007" starts reading on that date
# na.strings = c("?","") will convert missing values to NA_character_

PowerData <- fread("household_power_consumption.txt", skip = "1/2/2007", na.strings = c("?",""), nrows = rowsToRead)

# Read and set the names for PowerData
PowerNames <- names(fread("household_power_consumption.txt", nrows = 0))
setNames(PowerData, PowerNames)

# Create DateTime column which combines & converts Date and Time to POSIXct
PowerData$DateTime <- as.POSIXct(paste(PowerData$Date, PowerData$Time), format="%d/%m/%Y %H:%M:%S")

# Create plot as a png file
png(filename = "plot3.png", height = 480, width = 480)
plot(PowerData$DateTime, PowerData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(PowerData$DateTime, PowerData$Sub_metering_2, col = "red")
lines(PowerData$DateTime, PowerData$Sub_metering_3, col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.off()