library(tidyr)
library(lubridate)
#reading data

power<- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

#change date and time classes using Lubridate
power$Time<- paste(power$Date, power$Time)
power$Time<- strptime(power$Time, "%d/%m/%Y %H:%M:%S")
power$Date<-dmy(power$Date)

#subsetting

power<- subset(power, power$Date>= as.Date("2007-02-01") & power$Date<= as.Date("2007-02-02"))
power$Time<- as.POSIXct(power$Time)
newpow<-gather(power, sub_metering, value, Sub_metering_1:Sub_metering_3, -Date,-Time, -Global_reactive_power, -Voltage, -Global_intensity )
newpow$sub_metering<- parse_numeric(newpow$sub_metering)
png(filename = "plot3.png", width= 480, height=480)
plot(newpow$Time, newpow$value, type = "n", xlab = "", ylab = "Energy Sub Metering")
sub1<- subset(newpow, newpow$sub_metering==1)
sub2<- subset(newpow, newpow$sub_metering==2)
sub3<- subset(newpow, newpow$sub_metering==3)
points(sub1$Time, sub1$value, pch= NA_character_, lines(sub1$Time, sub1$value))
points(sub1$Time, sub1$value, pch= NA_character_, lines(sub1$Time, sub1$value))
points(sub2$Time, sub2$value, pch= NA_character_, lines(sub2$Time, sub2$value, col= "blue"))
points(sub3$Time, sub3$value, pch= NA_character_, lines(sub3$Time, sub3$value, col= "red"))
legend("topright", legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"), pch= c(NA,NA,NA), lwd=c(1,1,1), col=c("black", "blue","red"), pt.cex = 1, cex = 0.8)
dev.off()

