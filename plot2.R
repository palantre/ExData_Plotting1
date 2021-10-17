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

# Creating plot (Plot 2)
plot(datetime, hpc2$global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Saving as PNG file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()