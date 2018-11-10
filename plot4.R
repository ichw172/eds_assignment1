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
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))

#------------------------------------
# First plot
#------------------------------------
#Filter the '?' and select only the global active power
hpower_plot2 <- hpower_red %>% filter(Global_active_power != '?') %>% select(Global_active_power,Date,Time)

#Convert the values to numeric and create a new column DT containing the date
hpower_plot2$Global_active_power <- as.numeric(as.character(hpower_plot2$Global_active_power))
hpower_plot2 <- hpower_plot2 %>%  mutate(DT = as.POSIXct(strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")))

#Plot on the new column and active global power
plot(hpower_plot2$DT, hpower_plot2$Global_active_power, type = "l", lty = 1, ylab = 'Global Active Power (kilowatts)',xlab='')


#------------------------------------
# Second plot
#------------------------------------

#Filter the '?' and select only the global active power
hpower_plot4_1 <- hpower_red %>% filter(Voltage != '?') %>% select(Voltage,Date,Time)

#Convert the values to numeric and create a new column DT containing the date
hpower_plot4_1$Voltage <- as.numeric(as.character(hpower_plot4_1$Voltage))
hpower_plot4_1 <- hpower_plot4_1 %>%  mutate(DT = as.POSIXct(strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")))

#Plot on the new column and active global power
plot(hpower_plot4_1$DT, hpower_plot4_1$Voltage, type = "l", lty = 1, ylab = 'Voltage',xlab='datetime',axes=TRUE)


#------------------------------------
# Third plot
#------------------------------------
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


#------------------------------------
# Fourth plot
#------------------------------------
#Filter the '?' and select only the global active power
hpower_plot4_2 <- hpower_red %>% filter(Global_reactive_power != '?') %>% select(Global_reactive_power,Date,Time)

#Convert the values to numeric and create a new column DT containing the date
hpower_plot4_2$Global_reactive_power <- as.numeric(as.character(hpower_plot4_2$Global_reactive_power))
hpower_plot4_2 <- hpower_plot4_2 %>%  mutate(DT = as.POSIXct(strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")))


plot(x=hpower_plot4_2$DT,y=hpower_plot4_2$Global_reactive_power,type="l",ylab = 'Global_reactive_power', xlab='datetime')

dev.off()
