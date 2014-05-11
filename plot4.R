# Read the data, choose the data in "2007-02-01"|"2007-02-02"
setwd("d:/dropbox")
data <- read.table("household_power_consumption.txt", sep=';', header=T, 
                   colClasses = c('character', 'character', 'numeric',
                                  'numeric', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric'),
                   na.strings='?')
x <- paste(data$Date, data$Time)
data$datetime<-strptime(x, "%d/%m/%Y %H:%M:%S")
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data.plot<-subset(data, 
                  Date == "2007-02-01"|Date == "2007-02-02")
# Open device
png("plot4.png", height=480, width=480)

# Canvas segmentation
op=par(mfrow=c(2,2))
layout.show(4)

# Global Active Power 
plot(data.plot$datetime, 
     data.plot$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")

# Voltage 
plot(data.plot$datetime, data.plot$Voltage, type="l",ylab="Voltage", xlab="datetime")

# 3 Submetering 
plot(data.plot$datetime, 
     data.plot$Sub_metering_1, 
     col="black",
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(data.plot$datetime, data.plot$Sub_metering_2, col='red')
lines(data.plot$datetime, data.plot$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')

# Global reactive power 
with(data.plot, plot(datetime, Global_reactive_power, xlab='datetime', type="l"))

#eliminate the function of par
par(op)

# Close PNG file
dev.off()
