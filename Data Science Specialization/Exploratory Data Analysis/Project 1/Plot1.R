# Exploratory Data Analysis Project John Hopkins Coursera
# Author: Mehdi BENYAHIA

# Packages and Data
install.packages("data.table")
install.packages("dplyr")
library(data.table)
library(dplyr)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

#Load Data
powerdata <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")
powerdata <- filter(powerdata,(Date >= "2007-02-01") & (Date <= "2007-02-02"))
powerdata <- mutate(powerdata, DateTime = paste (Date, Time))
powerdata <- select(powerdata, DateTime, Global_active_power:Sub_metering_3)
powerdata$DateTime <- as.POSIXct(powerdata$DateTime)

#Plot 1
powerdata$Global_active_power <- as.numeric(as.character(powerdata$Global_active_power))
png("plot1.png", width=480, height=480)
hist(powerdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()