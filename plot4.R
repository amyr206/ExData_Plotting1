# Copyright Amy Richards 2015

# PURPOSE:
# --------
# This script fulfills #4 of 4 deliverables for Course Project 1 for the Johns Hopkins 
# Coursera Data Science Specialization class, Exploratory Data Analysis.
# Project description:
# https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions

# WHAT THIS SCRIPT DOES:
# ----------------------
# Electric power consumption data downloaded from the UCI Machine Learning Repository
# (https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)
# is read into R, and subsetted to include only data from Feb 1-2, 2007.
# From this data, 4 line plots showing global active power, voltage, 3 submeters,
# and global reactive power over 48 hours are generated.

# OUTPUT:
# -------
# PNG of line plots called plot4.png

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

# Subset to include only data from 2007-02-01 and 2007-02-02
subsetdata <- subset(rawdata, Date == "1/2/2007" | Date == "2/2/2007")

# Create a new column of POSIXct type that combines Date and Time column values
# Based on this discussion @ stackoverflow:
# http://stackoverflow.com/questions/16301204/r-converting-date-and-time-fields-to-posixct-with-hhmmss-format
subsetdata$datetime <- as.POSIXct(paste(subsetdata$Date, subsetdata$Time), 
                                  format = "%d/%m/%Y %H:%M:%S")

# Drop the now un-needed character date and time columns
subsetdata <- subsetdata[, 3:10]

# Set up the PNG output for the four line plots we're about to plot
png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px",
    pointsize = 12)

# Create our plots in a 2x2 configuration
par(mfrow = c(2,2))
with(subsetdata, {
        # Plot 1 - Global active power over 48 hours
        # ------------------------------------------
        # Create a line plot, setting axis labels to match example
        plot(x = datetime, y = Global_active_power,
             type = "l",
             xlab = "",
             ylab = "Global Active Power")
        
        # Plot 2 - Voltage over 48 hours
        # ------------------------------
        # Create a line plot
        plot(x = datetime, y = Voltage,
             type = "l")
        
        # Plot 3 - Submetering energy over 48 hours
        # -----------------------------------------
        # start plot with submeter 1, add the y-axis label
        plot(x = datetime, y = Sub_metering_1,
             type = "l",
             xlab = "",
             ylab = "Energy sub metering")
        
        # add submeter 2
        lines(x = datetime, y = Sub_metering_2,
              col = "red")
        
        # add submeter 3
        lines(x = datetime, y = Sub_metering_3,
              col = "blue")
        
        # add legend as per example
        legend("topright", 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               col = c("black", "red", "blue"),
               lwd = 1,
               bty = "n")
        
        # Plot 4 - Global reactive power over 48 hours
        # --------------------------------------------
        # Create a line plot
        plot(x = datetime, y = Global_reactive_power,
             type = "l")
})

# Close off the graphic device
dev.off()
