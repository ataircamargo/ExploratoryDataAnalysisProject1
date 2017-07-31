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
subhpc <- subset(hpc, subset = (Date >= "2007-02-04" & Date <= "2007-02-05"))

#Convert time
datetime <- paste(as.Date(subhpc$Date), subhpc$Time)
subhpc$Time <- as.POSIXct(datetime)

#Plot
hist(subhpc$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", col = "red", xlim = c(0,6), ylim = c(0, 1200))

#Save file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
