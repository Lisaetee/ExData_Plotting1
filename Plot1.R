
#Reading and subsetting data
PowerConsumption <- read.table("household_power_consumption.txt",skip=1,sep=";", header=TRUE, NA = "?", stringsAsFactors = FALSE)
      names(PowerConsumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")      
      subsetPowerConsumption <- subset(PowerConsumption, PowerConsumption$Date =="1/2/2007" | PowerConsumption$Date =="2/2/2007")      
     
# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
subsetPowerConsumption$Date <- as.Date(subsetPowerConsumption$Date, format="%d/%m/%Y")
      subsetPowerConsumption$Time <- strptime(subsetPowerConsumption$Time, format="%H:%M:%S")
      subsetPowerConsumption[1:1440,"Time"] <- format(subsetPowerConsumption[1:1440,"Time"],"2007-02-01 %H:%M:%S")
      subsetPowerConsumption[1441:2880,"Time"] <- format(subsetPowerConsumption[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
      
      
      # calling the basic plot function
      plot(subsetPowerConsumption$Time,as.numeric(as.character(subsetPowerConsumption$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 
      
      # annotating graph
      title(main="Global Active Power Vs Time")