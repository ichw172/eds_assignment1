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
#Filter the '?' and select only the global active power
hpower_plot2 <- hpower_red %>% filter(Global_active_power != '?') %>% select(Global_active_power,Date,Time)

#Convert the values to numeric and create a new column DT containing the date
hpower_plot2$Global_active_power <- as.numeric(as.character(hpower_plot2$Global_active_power))
hpower_plot2 <- hpower_plot2 %>%  mutate(DT = as.POSIXct(strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")))

#Plot on the new column and active global power
png(file="plot2.png",width=480,height=480)
plot(hpower_plot2$DT, hpower_plot2$Global_active_power, type = "l", lty = 1, ylab = 'Global Active Power (kilowatts)',xlab='')
dev.off()
