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

png("plot3.png", width=480, height=480)
with(sub.ds, plot(x = date.time, y = Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(sub.ds, lines(x = date.time, y = Sub_metering_2, col = "red"))
with(sub.ds, lines(x = date.time, y = Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), 
       lty = 1)
dev.off()

# pp <- ggplot(data = sub.ds, aes(x = date.time)) +
#   geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1")) +
#   geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2")) +
#   geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3")) +
#   scale_colour_manual(name = "", values = c("black", "red", "blue"))
# 
# pp <- pp + scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))
# pp <- pp + xlab("") + ylab("Energy sub metering")
# pp <- pp + theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
# 
# pp <- pp + theme(legend.background = element_rect(), legend.margin = unit(0, "cm"))
# pp <- pp + theme(legend.justification=c(1,1), legend.position=c(1,1)) 
# pp <- pp + theme(legend.background = element_rect(colour = "black", size = .5)) +
#   theme(legend.key = element_blank())
# 
# pp