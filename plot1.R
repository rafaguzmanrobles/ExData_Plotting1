library(dplyr)

## Read the data from the unzipped txt file 
data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE) 

##convert date and time and take only dates between 2007-02-01 and 2007-02-03
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subdata <- filter(data, Date >= as.Date("2007-02-01 00:00:00"), Date < as.Date("2007-02-03 00:00:00"))

subdata$DateTime <- paste(subdata$Date, subdata$Time)
subdata$DateTime <- strptime(subdata$DateTime, "%Y-%m-%d %H:%M:%S")

## Now subdata is ready to be used

# open the png device
png(filename="plot1.png")

## create the histograme
hist(subdata$Global_active_power, main="Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")

# close the device
dev.off()
