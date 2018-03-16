# download zip file
zipFilePath <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("zipFile"))
    download.file(zipFilePath, destfile = "zipFile")
#unzip file
if (!file.exists("household_power_consumption.txt"))
    unzip("zipFile")

# Grab the headings of the text file to be applied to the subset of data 
headings <- read.table("household_power_consumption.txt", sep = ";", nrows = 1)
headings <- unlist(headings)

# I'm just going to read in the subset of records here so as not to clog up memory
februaryData <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?", nrows = 2880, skip =  66637)

# add back the headings to the subset data
names(februaryData) <- headings

# add a new column that combines the date and time
februaryData$dateTime <- paste(februaryData$Date, februaryData$Time)

# convert date/time string to POSIXlt
februaryData$dateTime <- strptime(februaryData$dateTime, format = "%d/%m/%Y %H:%M:%S")


# create the line graph and create png in working directory

png("Plot3.png", width = 480, height = 480, units = "px")

plot(februaryData$dateTime, februaryData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(februaryData$dateTime, februaryData$Sub_metering_2, col = "red")
lines(februaryData$dateTime, februaryData$Sub_metering_3, col = "blue")

legend("topright", lty = c(1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
