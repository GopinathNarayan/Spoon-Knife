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

#Generating Plot-2 on Windows screen
#The second plot, line graph of Global Active Power
plot(HPCSubset$DateTime, HPCSubset$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")

#And now generating the plot as a png file
png(filename="plot2.png", width = 480, height = 480, units = "px", pointsize = 12,bg = "transparent")
plot(HPCSubset$DateTime, HPCSubset$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
