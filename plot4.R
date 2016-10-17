## Script assumes that you have downloaded the data file into your
## current working directory and the data is read in from your
## current working directory. The PNG file is written to the current 
## working directory.

## Read in data file to data frame, pwrConsump
pwrConsump <- read.csv("household_power_consumption.txt", 
              sep = ";", na.strings=c("NA", "?"))

## Subset the dataframe to include on data for dates
## 2007-02-01 to 2007-02-02
pwrConsump <- read.csv("household_power_consumption.txt", sep = ";", na.strings=c("?"))
pwrConsump <- pwrConsump[pwrConsump$Date == '1/2/2007' | pwrConsump$Date == '2/2/2007', ]

## Convert factor variables to date format
pwrConsump$Date <- as.Date(pwrConsump$Date, format = "%d/%m/%Y")

## Convert Time variable to POsIXlt time class 
pwrConsump$Time <- strptime(paste(pwrConsump$Date,pwrConsump$Time), format = "%Y-%m-%d %H:%M:%S")

## Open PNG device
png(file = "plot4.png", width = 480, height = 480, units = "px")

## Set up plot positions
par(mfrow = c(2,2))


## Create Top Left Plot
with (pwrConsump, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

## Create Top Right Plot
with (pwrConsump, plot(Time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

## Create Bottom Left Plot
with(pwrConsump, plot(Time, Sub_metering_1, 
                      ylim = range(c(Sub_metering_1, Sub_metering_2, Sub_metering_3)), 
                      xlab = "", 
                      ylab = "Energy sub metering", 
                      type = "n"))

with(pwrConsump,lines(Time, Sub_metering_1, type = "l", col = "black"))
with(pwrConsump,lines(Time, Sub_metering_2, type = "l", col = "red"))
with(pwrConsump,lines(Time, Sub_metering_3, type = "l", col = "blue"))

## Add a legend at the top right of the plot
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), bty = "n")

## Create Bottom Right Plot
with (pwrConsump, plot(Time, Global_reactive_power, type = "l", xlab = "datetime"))

## Close the PNG file device
dev.off()


