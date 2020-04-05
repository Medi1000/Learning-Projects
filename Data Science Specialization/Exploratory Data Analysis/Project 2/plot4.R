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

# Coal Subset
coal_class_code <- class_code[grepl("Coal", class_code$Short.Name), ]
coal_emissions_data <- emissions_data[emissions_data$SCC %in% coal_class_code$SCC, ]

coal_emissions_year <- aggregate(coal_emissions_data$Emissions,  by=list(coal_emissions_data$year), FUN=sum)
colnames(coal_emissions_year) <- c("Year", "Emissions")

#Plot 4
png("plot4.png", width=480, height=480)
qplot(Year, Emissions, data = coal_emissions_year, geom = "line") +
  ggtitle("US PM2.5 Emissions from Coal Related Sources") + 
  ylab("Total Emissions (tons)") + 
  xlab("Year") 
dev.off()