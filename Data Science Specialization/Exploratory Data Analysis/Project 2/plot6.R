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
baltimore_la_motor_subset <- subset(emissions_data, emissions_data$fips=="24510" | emissions_data$fips=="06037" & emissions_data$type=="ON-ROAD")
baltimore_la_motor_subset_by_year <- aggregate(baltimore_la_motor_subset $Emissions, by=list(baltimore_la_motor_subset $fips, baltimore_la_motor_subset$year), FUN=sum)
colnames(baltimore_la_motor_subset_by_year) <- c("City","Year", "Emissions")
baltimore_la_motor_subset_by_year$Year <- as.factor(baltimore_la_motor_subset_by_year$Year)
baltimore_la_motor_subset_by_year$City <- factor(baltimore_la_motor_subset_by_year$City, levels=c("06037", "24510"), labels=c("Los Angeles", "Baltimore")) 



#Plot 6
png("plot6.png", width=480, height=480)
ggplot(baltimore_la_motor_subset_by_year, aes(x=Year, y=Emissions)) + 
  geom_bar(stat="identity", aes(fill=City), position = "dodge") +
  guides(fill=guide_legend(title=NULL)) +
  labs(x="Year", y="PM2.5 Emissions (tons)") +
  ggtitle("Vehicle PM2.5 Emissions - Baltimore City and LA County") +
  theme(legend.position="bottom")
dev.off()