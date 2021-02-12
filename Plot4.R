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
png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2)) 

plot(sub_data$datetime, 
     sub_data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power", 
     cex = 0.2)
plot(sub_data$datetime, 
     sub_data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
plot(sub_data$datetime,
     sub_data$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")
lines(sub_data$datetime,
      sub_data$Sub_metering_2,
      type = "l",
      col = "red")
lines(sub_data$datetime,
      sub_data$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 2.5,
       col = c("black", "red", "blue"),
       bty = "n")
plot(sub_data$datetime,
     sub_data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()

rm(list = ls())