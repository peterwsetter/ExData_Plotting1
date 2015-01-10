## R file documents the creation of plot4.png for Exploratory
## Data Analysis Course Project 1
## This R script reads a subset covering 2007 Jan 1 & 2007 Jan 2
## of the Household Power Consumption data set
## from the UC Irvine Machine Learning Repository

## plot4.R creates plot4.png, a figure of four plots
## Histogram of Global Active Power
## The three submeters vs. time
## Voltage vs. time
## Global reacive power vs. time

## This R script uses the function fread from the data.table package

library(data.table)

## Calculate the number of data points over the two days
rowsToRead <- 2*24*60

## Read using fread
## skip = "1/2/2007" starts reading on that date
## na.strings = c("?","") will convert missing values to NA_character_

PowerData <- fread("/Users/petersetter/Downloads/household_power_consumption.txt", skip = "1/2/2007", na.strings = c("?",""), nrows = rowsToRead)

## Read and set the names for PowerData
PowerNames <- names(fread("/Users/petersetter/Downloads/household_power_consumption.txt", nrows = 0))
setNames(PowerData, PowerNames)

## Create DateTime column which combines & converts Date and Time to POSIXct
PowerData$DateTime <- as.POSIXct(paste(PowerData$Date, PowerData$Time), format="%d/%m/%Y %H:%M:%S")

## Create plot as a png file
png(filename = "plot4.png", height = 480, width = 480)

## Adjust parameters so the plots will be added to the figure column, filling
## the column first
par(mfcol = c(2,2))

## Reproduce plot2, Global Active Power vs. Time
plot(PowerData$DateTime, PowerData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Reproduce plot3, a plot of the three sub meters vs. time
plot(PowerData$DateTime, PowerData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(PowerData$DateTime, PowerData$Sub_metering_2, col = "red")
lines(PowerData$DateTime, PowerData$Sub_metering_3, col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

## Plot Voltage vs. Time
plot(PowerData$DateTime, PowerData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

## Plot Global reactive power vs. Time
plot(PowerData$DateTime, PowerData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()