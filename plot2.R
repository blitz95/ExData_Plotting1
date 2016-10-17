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
png(file = "plot2.png", width = 480, height = 480, units = "px")

## Create xyplot with lines connecting the points
with (pwrConsump, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))


## Close the PNG file device
dev.off()


