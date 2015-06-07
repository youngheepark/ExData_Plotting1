# Course Project1 - plot4.R
# 1. Loading 'Electric power consumption' dataset
# 2. Plot and save the PNG file (plot4.png)

# Loading data
dfile <- "household_power_consumption.txt"
epcAll <- read.table(dfile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
str(epcAll)
head(epcAll)

# select data from the dates 2007-02-01 and 2007-02-02
epc <- epcAll[epcAll$Date %in% c("1/2/2007", "2/2/2007"),]

# Convert date/time format
dt <- paste(epc$Date, epc$Time)
epc$dt <- strptime(dt, "%d/%m/%Y %H:%M:%S")
str(epc)

# Convert data format
epc$Global_active_power <- as.numeric(epc$Global_active_power)
epc$Global_reactive_power <- as.numeric(epc$Global_reactive_power)
epc$Voltage <- as.numeric(epc$Voltage)
epc$Global_intensity <- as.numeric(epc$Global_intensity)
epc$Sub_metering_1 <- as.numeric(epc$Sub_metering_1)
epc$Sub_metering_2 <- as.numeric(epc$Sub_metering_2)
str(epc)

# plot & save png file
par(mfrow = c(2, 2))

dev.copy(png, file="plot4.png", width = 480, height = 480)

with(epc, plot(dt, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
with(epc, plot(dt, Voltage, type="l", xlab="datetime", ylab="Voltage"))

with(epc, plot(dt, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(epc, lines(dt, Sub_metering_2, col="red"))
with(epc, lines(dt, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), bty="n", cex=0.8,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(epc, plot(dt, Global_reactive_power, type="l", xlab="datetime"))

dev.off()

