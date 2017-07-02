dataFile <-"household_power_consumption.txt"
#No sense in prefiltering, as we would have to red all the data, wil, filter later
dataFrame <- read.table(dataFile,header= TRUE,sep = ";",dec=".")
#Once we have the data, we filter the dates (rows) we need son further operations will be faster
dataFrame$Date <- as.Date(dataFrame$Date, format="%d/%m/%Y")
dataFrame <- dataFrame [(dataFrame$Date=="2007/02/01"| dataFrame$Date=="2007/02/02"),]
#For the active power we transform directly the data, decimal should be taken care of
dataFrame$Global_active_power <- as.numeric(gsub(',','.',dataFrame$Global_active_power))
dataFrame$Voltage <- as.numeric(gsub(',','.',dataFrame$Voltage))
dataFrame$Global_reactive_power <- as.numeric(gsub(',','.',dataFrame$Global_reactive_power))
dataFrame$Sub_metering_1 <- as.numeric(gsub(',','.',dataFrame$Sub_metering_1))
dataFrame$Sub_metering_2 <- as.numeric(gsub(',','.',dataFrame$Sub_metering_2))
dataFrame$Sub_metering_3 <- as.numeric(gsub(',','.',dataFrame$Sub_metering_3))
#We add and extra column with the timestamp combining both Time and date
dataFrame <- transform(dataFrame, datetime=as.POSIXct(paste(dataFrame$Date, dataFrame$Time)), "%d/%m/%Y %H:%M:%S")
#The layout(2x2) is configured
par(mfrow=c(2,2))
#First plot
plot(dataFrame$datetime, dataFrame$Global_active_power,type="l",xlab="",ylab="Global Active Power")
#Second plot
plot(dataFrame$datetime, dataFrame$Voltage,type="l",xlab="datetime",ylab="Voltage")
#Third plot
plot(dataFrame$datetime, dataFrame$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dataFrame$datetime,dataFrame$Sub_metering_2,col="red")
lines(dataFrame$datetime,dataFrame$Sub_metering_3,col="blue")
legend("topright",col=c("black", "red", "blue"),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1)
#Last Plot
plot(dataFrame$datetime, dataFrame$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
#We export to a file of the given size and name 
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()