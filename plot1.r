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

#construct plot 1
png(filename="./plot1.png", width=480, height=480, units = "px")
par(bg=NA)
hist(data$Global_active_power, col='red',main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")
dev.off()
