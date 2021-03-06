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

#Total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") by year
baltimore_subset <- subset(emissions_data, emissions_data$fips=="24510")
baltimore_emissions_by_year <- aggregate(baltimore_subset$Emissions, by=list(year=baltimore_subset$year), FUN=sum)

#Plot 2
png("plot2.png", width=480, height=480)
barplot(baltimore_emissions_by_year$x, names.arg = baltimore_emissions_by_year$year, main="Total Emissions of PM2.5 in Baltimore City", xlab="Total emissions of PM2.5 (tons)", ylab="Year", col = "red")
dev.off()
