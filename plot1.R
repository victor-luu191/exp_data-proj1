ds <- read.csv("../household_power_consumption.txt", sep = ";") 
ds$Date <- as.Date(ds$Date, "%d/%m/%Y")

sub.ds <- subset(ds, Date == as.Date("01/02/2007", "%d/%m/%Y") | 
                   Date ==  as.Date("02/02/2007", "%d/%m/%Y"))
for (col in 3:8) {
  sub.ds[ , col] <- as.numeric(sub.ds[ , col])
}
png("plot1.png", width=480, height=480)
hist(sub.ds$Global_active_power/500, xlab = "Global Active Power(kilowatts)", main = "Global Active Power", 
     col = "red")
dev.off()




