library(ggplot2)
library(scales) # to obtain a desired time scale/break
library(grid)

ds <- read.csv("../household_power_consumption.txt", sep = ";") 
ds$Date <- as.Date(ds$Date, "%d/%m/%Y")

sub.ds <- subset(ds, Date == as.Date("01/02/2007", "%d/%m/%Y") | 
                   Date ==  as.Date("02/02/2007", "%d/%m/%Y"))
for (col in 3:8) {
  sub.ds[ , col] <- as.numeric(sub.ds[ , col])
}

sub.ds <- transform(sub.ds, date.time = paste(Date, Time))
sub.ds$date.time <- strptime(sub.ds$date.time, "%Y-%m-%d %H:%M:%S")
sub.ds <- transform(sub.ds, scaled.GAP = Global_active_power/500)

png("plot4.png", width = 480, height = 480)
op <- par(mfrow=c(2,2))
## 1st plot
plot(x = sub.ds$date.time, y = sub.ds$scaled.GAP, type = "l", 
     xlab = "", ylab = "Global Active Power")
## 2nd plot
with(sub.ds, plot(x = date.time, y = Voltage/4, type = "l", xlab = "datetime", ylab = "Voltage"))
## 3rd plot
with(sub.ds, plot(x = date.time, y = Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(sub.ds, lines(x = date.time, y = Sub_metering_2, col = "red"))
with(sub.ds, lines(x = date.time, y = Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), 
       lty = 1, bty = "n", cex = .8)
## 4th plot
with(sub.ds, plot(x = date.time, y = Global_reactive_power, type = "l", 
                  xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()
par(op)