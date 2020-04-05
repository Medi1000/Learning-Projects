# Exploratory Data Analysis Second Project John Hopkins Coursera
# Author: Mehdi BENYAHIA

# Get Data
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Read Data
emissions_data <- readRDS("summarySCC_PM25.rds")
class_code <- readRDS("Source_Classification_Code.rds")
emissions_by_year <- aggregate(emissions_data$Emissions, by=list(year=emissions_data$year), FUN=sum)

#Plot 1
png("plot1.png", width=480, height=480)
barplot(emissions_by_year$x, names.arg = emissions_by_year$year, main="Total Emissions of PM2.5 in United States", xlab="Total emissions of PM2.5 (tons)", ylab="Year", col = "blue")
dev.off()