## R file documents the creation of plot2.png for Exploratory
## Data Analysis Course Project 1

## This R script reads a subset covering 2007 Jan 1 & 2007 Jan 2
## of the Household Power Consumption data set
## from the UC Irvine Machine Learning Repository

## plot2.R plots Global Active Power vs. Time and saves it as
## plot2.png

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
png(filename = "plot2.png", height = 480, width = 480)
plot(PowerData$DateTime, PowerData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()