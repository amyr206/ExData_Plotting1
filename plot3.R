# Copyright Amy Richards 2015

# PURPOSE:
# --------
# This script fulfills #3 of 4 deliverables for Course Project 1 for the Johns Hopkins 
# Coursera Data Science Specialization class, Exploratory Data Analysis.
# Project description:
# https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions

# WHAT THIS SCRIPT DOES:
# ----------------------
# Electric power consumption data downloaded from the UCI Machine Learning Repository
# (https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)
# is read into R, and subsetted to include only data from Feb 1-2, 2007.
# From this data, a line plot showing patterns of global active power in 
# kilowatts for three types of submeters over 48 hours is generated.

# OUTPUT:
# -------
# PNG of line plot called plot3.png

# REQUIRED FILES:
# ---------------
# This script assumes that the electric power consumption datafile has been 
# downloaded and unzipped into the user's working directory, along with this 
# script.

# REQUIRED LIBRARIES:
# -------------------
# Only base R is used, no additional libraries are required.



# Read in the data
rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep =";",
                      nrows = 2075259, na.strings = "?", as.is = TRUE)

# Subset to include only data from 2007-02-01 and 2007-02-02, and only the
# Date, Time, and Sub_metering_1, Sub_metering_2, and Sub_metering_3
subsetdata <- subset(rawdata, Date == "1/2/2007" | Date == "2/2/2007", 
                     select = c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Rename the columns to make them easier to reference
names(subsetdata) <- c("date", "time", "sub1", "sub2", "sub3")

# Create a new column of POSIXct type that combines Date and Time column values
# Based on this discussion @ stackoverflow:
# http://stackoverflow.com/questions/16301204/r-converting-date-and-time-fields-to-posixct-with-hhmmss-format
subsetdata$datetime <- as.POSIXct(paste(subsetdata$date, subsetdata$time), 
                                  format = "%d/%m/%Y %H:%M:%S")

# Drop the now un-needed character date and time columns
subsetdata <- subsetdata[, c("datetime", "sub1", "sub2", "sub3")]

# Set up the PNG output for the line plot we're about to plot
png(filename = "plot3.png",
    width = 480,
    height = 480,
    units = "px",
    pointsize = 12)

# Create line plot for each of 3 submeters, 
# setting axis labels, colors, and legend to match example

# start plot with submeter 1, add the y-axis label
plot(x = subsetdata$datetime, y = subsetdata$sub1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")

# add submeter 2
lines(x = subsetdata$datetime, y = subsetdata$sub2,
      col = "red")

# add submeter 3
lines(x = subsetdata$datetime, y = subsetdata$sub3,
      col = "blue")

# add legend as per example
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lwd = 1)

# Close off the graphic device
dev.off()