dataFile <-"household_power_consumption.txt"
#No sense in prefiltering, as we would have to red all the data, will filter later
dataFrame <- read.table(dataFile,header= TRUE,sep = ";")
dataFrame$Date <- as.Date(dataFrame$Date, format="%d/%m/%Y")
#Once we have the data, we filter the dates (rows) we need son further operations will be faster
dataFrame <- dataFrame [(dataFrame$Date=="2007/02/01"| dataFrame$Date=="2007/02/02"),]
#For the active power we transform directly the data, decimal should be taken care of
dataFrame$Global_active_power <- as.numeric(gsub(',','.',dataFrame$Global_active_power))
#We plot
hist(dataFrame$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
#We copy the results to a PNG file of the given size
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()