dataFile <-"household_power_consumption.txt"
#No sense in prefiltering, as we would have to red all the data, wil, filter later
dataFrame <- read.table(dataFile,header= TRUE,sep = ";",dec=".")
dataFrame$Date <- as.Date(dataFrame$Date, format="%d/%m/%Y")
#Once we have the data, we filter the dates (rows) we need son further operations will be faster
dataFrame <- dataFrame [(dataFrame$Date=="2007/02/01"| dataFrame$Date=="2007/02/02"),]
#For the active power we transform directly the data, decimal should be taken care of
dataFrame$Global_active_power <- as.numeric(gsub(',','.',dataFrame$Global_active_power))
#We add and extra column with the timestamp combining both Time and date
dataFrame <- transform(dataFrame, datetime=as.POSIXct(paste(dataFrame$Date, dataFrame$Time)), "%d/%m/%Y %H:%M:%S")
#We plot the graph
plot(dataFrame$datetime, dataFrame$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
#We copy the results to a PNG file of the given size
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()