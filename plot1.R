
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
hpower_plot1 <- hpower_red %>% filter(Global_active_power != '?') %>% select(Global_active_power)

#Convert the values to numeric
hpower_plot1$Global_active_power <- as.numeric(as.character(hpower_plot1$Global_active_power))

#Plot the graph
png(file="plot1.png",width=480,height=480)
hist(hpower_plot1$Global_active_power, xlab='Global Active Power (kilowatts)', ylab='Frequency', main = 'Global Active Power', col='red' )
dev.off()