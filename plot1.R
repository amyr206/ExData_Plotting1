# Copyright Amy Richards 2015

# PURPOSE:
# --------
# This script fulfills #1 of 4 deliverables for Course Project 1 for the Johns Hopkins 
# Coursera Data Science Specialization class, Exploratory Data Analysis.
# Project description:
# https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions

# WHAT THIS SCRIPT DOES:
# ----------------------
# Electric power consumption data downloaded from the UCI Machine Learning Repository
# (https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption)
# is read into R, and subsetted to include only data from Feb 1-2, 2007.
# From this data, a histogram showing distribution of global active power in 
# kilowatts is plotted.

# OUTPUT:
# -------
# PNG of histogram called plot1.png

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
# Global_active_power column
subsetdata <- subset(rawdata, Date == "1/2/2007" | Date == "2/2/2007", select = Global_active_power)

# Rename the Global_active_power column so it's easier to reference in code
names(subsetdata) <- "globalactivepower"

# Set up the PNG output for the histogram we're about to plot
png(filename = "plot1.png",
    width = 480,
    height = 480,
    units = "px",
    pointsize = 12)

# plot the histogram, setting the bar colors, the x- and y-axis titles, and
# the plot title to match the example
hist(subsetdata$globalactivepower, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")

# Close off the graphic device
dev.off()