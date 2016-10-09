library(lubridate)
#reading data

power<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

#change date and time classes using Lubridate
power$Time<- paste(power$Date, power$Time)
power$Time<- strptime(power$Time, "%d/%m/%Y %H:%M:%S")
power$Date<-dmy(power$Date)

#subsetting

power<- subset(power, power$Date>= as.Date("2007-02-01") & power$Date<= as.Date("2007-02-02"))

#creating png and plotting

png(file="plot2.png", width= 480, height=480)
plot(power$Time, power$Global_active_power, pch= NA_integer_,xlab = "", ylab = "Global Active Power (kilowatts)" )
lines(power$Time, power$Global_active_power)
dev.off()