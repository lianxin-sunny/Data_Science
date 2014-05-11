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
png("plot2.png", height=480, width=480)

# Build time series
plot(data.plot$datetime, data.plot$Global_active_power,type="l",
     xlab="", 
     ylab="Global Active Power (kilowatts)")
# Close device
dev.off()

