# Exploratory Data Analysis Second Project John Hopkins Coursera
# Author: Mehdi BENYAHIA

# Packages & Data
install.packages("ggplot2")
library(ggplot2)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Read Data
emissions_data <- readRDS("summarySCC_PM25.rds")
class_code <- readRDS("Source_Classification_Code.rds")

#Total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") by year
baltimore_subset <- subset(emissions_data, emissions_data$fips=="24510")
baltimore_by_type_year <- aggregate(baltimore_subset$Emissions, by=list(baltimore_subset$type, baltimore_subset$year), FUN=sum)
colnames(baltimore_by_type_year) <- c("Type", "Year", "Emissions")

#Plot 3
png("plot3.png", width=480, height=480)
qplot(Year, Emissions, data = baltimore_by_type_year, color = Type, geom = "line") +
  ggtitle("Total Emissions of PM2.5 in Baltimore City By Pollutant Type") + 
  ylab("Total Emissions (tons)") + 
  xlab("Year") 
dev.off()