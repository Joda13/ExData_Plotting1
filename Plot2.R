library(dplyr)

# read the raw data from the unzipped file
data_raw <- read.table("data/household_power_consumption.txt", 
                       dec = ".", 
                       sep = ";",
                       na.strings = "?",
                       stringsAsFactors = FALSE,
                       header = TRUE) 

# create a subset with only relevant dates
sub_data <- subset(data_raw, data_raw$Date == "1/2/2007" | data_raw$Date == "2/2/2007") %>%
        mutate(datetime = strptime(paste(Date, Time, sep=" "),
                                   format = "%d/%m/%Y %H:%M:%S"))

# create PNG output
png(file = "plot2.png", width = 480, height = 480)

with(sub_data, plot(sub_data$datetime, sub_data$Global_active_power,
                    type = "l",
                    xlab = "", 
                    ylab = "Global Active Power (kilowatts)"))

dev.off()

rm(list = ls())