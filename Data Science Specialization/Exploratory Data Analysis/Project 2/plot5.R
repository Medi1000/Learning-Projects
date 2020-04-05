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

#Subset Baltimore/ motor vehicule
baltimore_motor_subset <- subset(emissions_data, emissions_data$fips=="24510" & emissions_data$type=="ON-ROAD")
baltimore_motor_subset_by_year <- aggregate(baltimore_motor_subset$Emissions, by=list(baltimore_motor_subset$year), FUN=sum)
colnames(baltimore_motor_subset_by_year) <- c("Year", "Emissions")
baltimore_motor_subset_by_year$Year <- as.factor(baltimore_motor_subset_by_year$Year)

#Plot 5
png("plot5.png", width=480, height=480)
ggplot(baltimore_motor_subset_by_year, aes(x=Year, y=Emissions)) + geom_bar(stat="identity") +
  ggtitle("Baltimore Total Emissions of PM2.5 related to motor Vehicle") + 
  ylab("Total Emissions (tons)") + 
  xlab("Year") 
dev.off()