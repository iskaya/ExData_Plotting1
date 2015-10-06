# check if file exists, if not download and unzip
if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
} else {
    file <- "household_power_consumption.txt"
}

# preprocess data
power <- read.table(file, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
power_sub <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"), ]
power_sub$Time <- as.POSIXct(paste(power_sub$Date, as.character(power_sub$Time)))
power_sub$Time <- strftime(power_sub$Time, format="%H:%M:%S")
power_sub$Global_active_power <- as.numeric(as.character(power_sub$Global_active_power))
power_sub$Global_reactive_power <- as.numeric(as.character(power_sub$Global_reactive_power))
power_sub$Voltage <- as.numeric(as.character(power_sub$Voltage))
power_sub$Global_intensity <- as.numeric(as.character(power_sub$Global_intensity))
power_sub$Sub_metering_1 <- as.numeric(as.character(power_sub$Sub_metering_1))
power_sub$Sub_metering_2 <- as.numeric(as.character(power_sub$Sub_metering_2))
power_sub$Sub_metering_3 <- as.numeric(as.character(power_sub$Sub_metering_3))
power_sub$Time <- as.POSIXct(paste(power_sub$Date, as.character(power_sub$Time)))

# plot
plot(power_sub$Time, power_sub$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(power_sub$Time, power_sub$Sub_metering_2, type="l", col="red")
lines(power_sub$Time, power_sub$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1   ", "Sub_metering_2   ", "Sub_metering_3   "), cex=.75, lty=c(1,1), lwd=c(1,1))
dev.copy(png, "plot3.png", height=480, width=480)
dev.off()
