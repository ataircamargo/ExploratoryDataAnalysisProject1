#Instructions
#
#This assignment uses data from the UC Irvine Machine Learning Repository, 
#a popular repository for machine learning datasets. In particular, we will be 
#using the ???Individual household electric power consumption Data Set??? which I 
#have made available on the course web site:
#    
#Dataset: Electric power consumption [20Mb]
#Description: Measurements of electric power consumption in one household 
#with a one-minute sampling rate over a period of almost 4 years. Different 
#electrical quantities and some sub-metering values are available.


#assign file url
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#assign file name
filename <- power.zip

#download dataset
if (!file.exists(filename)) {
    download.file(fileurl, filename)
}

#unzip dataset
if (!file.exists("household_power_consumption.txt")) {
    unzip(filename)
}

#read file
hpc <- read.csv(file = "household_power_consumption.txt", header = TRUE, sep = ";", strip.white = TRUE, stringsAsFactors = FALSE, na.strings = "?")

#prepare sub data
hpc$Date <- as.Date(hpc$Date, format = "%m/%d/%Y")

#subset data
subhpc <- subset(hpc, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

#Convert time
datetime <- paste(as.Date(subhpc$Date), subhpc$Time)
subhpc$datetime <- as.POSIXct(datetime)

#Plot matrix
par(mfrow = c(2,2))

#Plot

plot(subhpc$datetime, subhpc$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(subhpc$datetime, subhpc$Voltage, type = "l", ylab = "Voltage", xlab = "Datetime")

plot(subhpc$datetime, subhpc$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", ylim = c(0, 3))
lines(subhpc$datetime, subhpc$Sub_metering_2, type = "l", col = "red")
lines(subhpc$datetime, subhpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

plot(subhpc$datetime, subhpc$Global_reactive_power, type = "l", ylab = "Global_Reactive_Time", xlab = "Datetime")


#Save file
dev.copy(png, file = "plot4.png", height = 680, width = 800)
dev.off()
