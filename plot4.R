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
png(filename="plot4.png")

## first we split the device into a 2x2 matrix
par(mfrow = c(2, 2))

########################################################
##           creates the first plot                  ##
########################################################
with(subdata,plot(subdata$DateTime, subdata$Global_active_power, 
             xlab = "", 
             ylab="Global Active Power", 
             type="l", 
             cex.lab=0.8))

########################################################
##           creates the second plot                  ##
########################################################
        
with(subdata,plot(subdata$DateTime, subdata$Voltage, 
             xlab = "datetime", 
             ylab="Voltage", 
             type="l", 
             cex.lab=0.8))

########################################################
##           creates the third plot                  ##
########################################################
with(subdata,plot(DateTime,Sub_metering_1, 
          type="l",
          xlab = "", 
          ylab="Energy sub metering"))

        ## add data from sub_metering_2
with(subdata,lines(DateTime,Sub_metering_2,col="red",lwd=2.5))
        ## add data from sub_metering_3
with(subdata,lines(DateTime,Sub_metering_3,col="blue",lwd=2.5))
        ## add the legend
legend("topright", # places a legend at the appropriate place 
               c("sub_metering_1", "sub_metering_2", "sub_metering_3"), # puts text in the legend 
               lty=c(1,1,1), # gives the legend appropriate symbols (lines)      
               lwd=c(2.5,2.5, 2.5),
               col=c("black","red", "blue"), # gives the legend lines the correct color and width
               cex = 0.5) #makes the legend smaller

########################################################
##           creates the fourth plot                  ##
########################################################
with(subdata,plot(subdata$DateTime, subdata$Global_reactive_power, 
             xlab = "datetime", 
             ylab="Global_reactive_power", 
             type="l", 
             cex.lab=0.8))

# close the device
dev.off()
