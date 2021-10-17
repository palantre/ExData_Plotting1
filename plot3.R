library(tidyverse)
library(here)
library(janitor)

# Download and unzip file
path <- here("hpc.zip")
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              , destfile = path)
unzip(zipfile = "hpc.zip")

# Readr already read Date and Time columns as Date/Time classes
hpc <- read_delim("household_power_consumption.txt", delim = ";")

# Cleaning and subsetting dataset
hpc <- clean_names(hpc)
hpc2 <- hpc %>%
  filter(date == '1/2/2007' | date == '2/2/2007') %>%
  # Combining date and time
  mutate(datetime = strptime(paste(date, time, sep=" "), "%d/%m/%Y %H:%M:%S"))

# Creating plot (Plot 3)
plot(datetime, hpc2$sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, hpc2$sub_metering_2, type="l", col="red")
lines(datetime, hpc2$sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# Saving as PNG file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()