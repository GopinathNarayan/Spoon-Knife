#Code for reading in the data, and generating plot1.png

#Code for reading data, and related data cleaning and extracting code

HPCData = read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

#Converting the text data to number
HPCData$Global_active_power = as.numeric(HPCData$Global_active_power)
HPCData$Global_reactive_power=as.numeric(HPCData$Global_reactive_power)
HPCData$Voltage =as.numeric(HPCData$Voltage)
HPCData$Global_intensity = as.numeric(HPCData$Global_intensity)
HPCData$Sub_metering_1= as.numeric(HPCData$Sub_metering_1)
HPCData$Sub_metering_2= as.numeric(HPCData$Sub_metering_2)
HPCData$Sub_metering_3= as.numeric(HPCData$Sub_metering_3)

#converting the text representation of date to a Date field
HPCData$Date2 = as.Date(HPCData$Date, format="%d/%m/%Y")


# Extracting the two days data,  2007-02-01 and 2007-02-02,  to a separate subset
HPCSubset = subset(HPCData, HPCData$Date2== as.Date("2007-02-01") | HPCData$Date2== as.Date("2007-02-02"))

str(HPCSubset)
summary(HPCSubset)

#Combining the date and timestamp data to a single text field
HPCSubset$DateTimeChr = paste(HPCSubset$Date2,HPCSubset$Time, sep=" ")

#Converting the combined text field to a time stamp field, containing both date and time
HPCSubset$DateTime= strptime(HPCSubset$DateTimeChr, format="%Y-%m-%d %H:%M:%S")

#The data is now ready for graphing--------

#Generating Plot-4 on Windows screen
#The fourth plot, comprising four plots in a single layout
#Using mfrow parameter to show on single layout
par(mfrow=c(2,2))

#1 Plot component
plot(HPCSubset$DateTime, HPCSubset$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")

#2 Plot component
plot(HPCSubset$DateTime, HPCSubset$Voltage,type="l", xlab ="datetime", ylab="Voltage")

#3 Plot component
plot(HPCSubset$DateTime, HPCSubset$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering")
lines(HPCSubset$DateTime, HPCSubset$Sub_metering_2,type="l", col="red")
lines(HPCSubset$DateTime, HPCSubset$Sub_metering_3,type="l", col="blue")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))

#4 Plot component
plot(HPCSubset$DateTime, HPCSubset$Global_reactive_power,type="l", xlab="datetime", ylab="Global_reactive_power")


#All plots generated, now to generate png


#And now generating the plot as a png file
png(filename="plot4.png", width = 480, height = 480, units = "px", pointsize = 12,bg = "transparent")
par(mfrow=c(2,2))

#1 Plot component
plot(HPCSubset$DateTime, HPCSubset$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")

#2 Plot component
plot(HPCSubset$DateTime, HPCSubset$Voltage,type="l", xlab ="datetime", ylab="Voltage")

#3 Plot component
plot(HPCSubset$DateTime, HPCSubset$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering")
lines(HPCSubset$DateTime, HPCSubset$Sub_metering_2,type="l", col="red")
lines(HPCSubset$DateTime, HPCSubset$Sub_metering_3,type="l", col="blue")
legend("topright", lty=1, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))

#4 Plot component
plot(HPCSubset$DateTime, HPCSubset$Global_reactive_power,type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
