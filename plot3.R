#Load the libraries
knitr::opts_chunk$set(echo = TRUE)
library(dplyr)
library(datasets)
library(tidyverse)
library(lubridate)

#Load the dataset, the txt data file is in the same directory
hpower <- read.table(file='household_power_consumption.txt',sep = ';',header = TRUE)
hpower_red <- hpower %>% filter(Date=='1/2/2007' | Date=='2/2/2007')

#Create the plot
png(file="plot3.png",width=480,height=480)
#Filter the '?' and select only the global active power
hpower_plot3_1 <- hpower_red %>% filter(Sub_metering_1 != '?') %>% select(Sub_metering_1,Date,Time)
hpower_plot3_2 <- hpower_red %>% filter(Sub_metering_2 != '?') %>% select(Sub_metering_2,Date,Time)
hpower_plot3_3 <- hpower_red %>% filter(Sub_metering_3 != '?') %>% select(Sub_metering_3,Date,Time)

#Convert the values to numeric and create a new column DT containing the date
hpower_plot3_1$Sub_metering_1 <- as.numeric(as.character(hpower_plot3_1$Sub_metering_1))
hpower_plot3_1 <- hpower_plot3_1 %>%  mutate(DT = as.POSIXct(strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")))

hpower_plot3_2$Sub_metering_2 <- as.numeric(as.character(hpower_plot3_2$Sub_metering_2))
hpower_plot3_2 <- hpower_plot3_2 %>%  mutate(DT = as.POSIXct(strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")))

hpower_plot3_3$Sub_metering_3 <- as.numeric(as.character(hpower_plot3_3$Sub_metering_3))
hpower_plot3_3 <- hpower_plot3_3 %>%  mutate(DT = as.POSIXct(strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")))



#Plot on the new column and eneergy sub metering
plot(hpower_plot3_1$DT, hpower_plot3_1$Sub_metering_1, type = "l", lty = 1, ylab = 'Energy sub metering',xlab='',col=153)

lines(hpower_plot3_2$DT, hpower_plot3_2$Sub_metering_2, type = "l", lty = 1, ylab = 'Energy sub metering',xlab='',col='red')

lines(hpower_plot3_3$DT, hpower_plot3_3$Sub_metering_3, type = "l", lty = 1, ylab = 'Energy sub metering',xlab='',col='blue')

legend("topright",col = c(153,"blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
       , lwd=2 )
dev.off()
