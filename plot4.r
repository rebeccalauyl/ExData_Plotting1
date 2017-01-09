#download and unzip file
if(!file.exists('data'))dir.create('data')
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile<-"./data/household_power_consumption.zip"
if(!file.exists('./data/household_power_consumption.zip'))download.file(url, destfile)
if(!file.exists('./data/household_power_consumption.txt'))unzip(destfile, exdir='./data')

#read data into R
txt <- readLines('./data/household_power_consumption.txt')
data <- read.table(text=grep("^[1,2]/2/2007",txt, value=TRUE), sep=';', header=TRUE, na.strings = '?',
                   col.names = c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1','Sub_metering_2', 'Sub_metering_3'))
data$Date2 <- as.Date(data$Date, format = '%d/%m/%Y')
data$datetime <- as.POSIXct(paste(data$Date2, data$Time))

#construct plot 4
png(filename="./plot4.png", width=480, height=480, units = "px")
par(mfrow=c(2,2), bg=NA)
##1
plot(data$datetime, data$Global_active_power, xlab = '', ylab = 'Global Active Power', type = 'l')
##2
plot(data$datetime, data$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
##3
plot(data$datetime,data$Sub_metering_1,type="l",col="black", xlab="", ylab="Energy sub metering")
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")
legend("topright", lwd=c(2.5,2.5),bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"))
##4
plot(data$datetime, data$Global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l')
dev.off()