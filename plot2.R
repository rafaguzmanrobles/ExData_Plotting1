library(dplyr)
Sys.setlocale("LC_ALL", "English") ## just in case your environment is not in english

## Read the data from the unzipped txt file 
data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE) 

##convert date and time and take only dates between 2007-02-01 and 2007-02-03
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subdata <- filter(data, Date >= as.Date("2007-02-01 00:00:00"), Date < as.Date("2007-02-03 00:00:00"))

subdata$DateTime <- paste(subdata$Date, subdata$Time)
subdata$DateTime <- strptime(subdata$DateTime, "%Y-%m-%d %H:%M:%S")

## Now subdata is ready to be used

# open the png device
png(filename="plot2.png")

## create the plot
plot(subdata$DateTime, subdata$Global_active_power, 
     xlab = "", 
     ylab="Global Active Power (kilowatts)", 
     type="l", 
     cex.lab=0.8)

# close the device
dev.off()
