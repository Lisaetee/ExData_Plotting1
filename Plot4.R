# Reading subsetting 
subsetPowerConsumption <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(subsetPowerConsumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subsetPowerConsumption <- subset(subsetPowerConsumption,subsetPowerConsumption$Date=="1/2/2007" | subsetPowerConsumption$Date =="2/2/2007")

# Date and Time to  Date and POSIXlt
subsetPowerConsumption$Date <- as.Date(subsetPowerConsumption$Date, format="%d/%m/%Y")
subsetPowerConsumption$Time <- strptime(subsetPowerConsumption$Time, format="%H:%M:%S")
subsetPowerConsumption[1:1440,"Time"] <- format(subsetPowerConsumption[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subsetPowerConsumption[1441:2880,"Time"] <- format(subsetPowerConsumption[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# composite plot
par(mfrow=c(2,2))

# plot function for the 4 plots that form the graph
with(subsetPowerConsumption,{
  plot(subsetPowerConsumption$Time,as.numeric(as.character(subsetPowerConsumption$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subsetPowerConsumption$Time,as.numeric(as.character(subsetPowerConsumption$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(subsetPowerConsumption$Time,subsetPowerConsumption$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
   with(subsetPowerConsumption,lines(Time,as.numeric(as.character(Sub_metering_1))))
   with(subsetPowerConsumption,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
   with(subsetPowerConsumption,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
   legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.2)
  plot(subsetPowerConsumption$Time,as.numeric(as.character(subsetPowerConsumption$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})

export to png