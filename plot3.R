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
png("plot3.png", height=480, width=480)

# Build time series
plot(data.plot$datetime, data.plot$Sub_metering_1,
     col="black",
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(data.plot$datetime, data.plot$Sub_metering_2, col='red')
lines(data.plot$datetime, data.plot$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'))

# Close device
dev.off()
