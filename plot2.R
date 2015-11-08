library(ggplot2)

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

with(sub.ds, qplot(x = date.time, y = scaled.GAP, geom = "line",
                   xlab = "", ylab = "Global Active Power(kilowatts)"))

library(scales) # to obtain a desired time scale/break
png("plot2.png", width=480, height=480)
## use date_format("%a") to get weekday in abbr form
last_plot() + scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))
dev.off()
