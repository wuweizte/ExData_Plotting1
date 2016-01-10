library(data.table)

# select dates and find the sequence range of the required period
dataset_date <- fread("household_power_consumption.txt", 
                      header = TRUE, sep = ";", select = 1, na.strings = "?")

Require_date_index <- which(dataset_date[[1]] %in%  c("1/2/2007","2/2/2007"))

start_index <- min(Require_date_index)

Project_Assignment_header <- fread("household_power_consumption.txt", 
                                   header = TRUE, sep = ";",nrows = 0)

#Considering the header, so 'start_index' rows should be skipped
Project_Assignment_data <- fread("household_power_consumption.txt", 
                                 header = FALSE, sep = ";",skip = start_index,
                                 nrows = length(Require_date_index),
                                 na.strings = "?")

colnames(Project_Assignment_data) <- colnames(Project_Assignment_header)

## Making the 4th plot consisting of 4 subplots
op <- par(mfrow = c(2,2))

## Making the 1st sub-plot
plot(Project_Assignment_data$Global_active_power, type = "l", 
     axes = FALSE,xlab = "",ylab = "Global Active Power")

axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(2)
box()

## Making the 2nd sub-plot
plot(Project_Assignment_data$Voltage, type = "l", 
     axes = FALSE,xlab = "datetime",ylab = "Voltage")

axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(2)
box()

## Making the 3rd sub-plot
plot(Project_Assignment_data$Sub_metering_1, type = "l", 
     axes = FALSE,xlab = "",ylab = "Energy sub metering")

axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(2)


lines(Project_Assignment_data$Sub_metering_2,col = "red")
lines(Project_Assignment_data$Sub_metering_3,col = "blue")

Text_legend <- paste("Sub_metering_",1:3,sep = "")
legend("topright", col = c("black","red","blue"),lty = 1,cex = 0.8,
       legend = Text_legend, text.width = strwidth("10000000000"),
       bty = "n")
       
box()

## Making the 4th sub-plot
plot(Project_Assignment_data$Global_reactive_power, type = "l", 
     axes = FALSE,xlab = "datetime",ylab = "Global_reactive_power")


axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(2, at = c(0,0.1,0.2,0.3,0.4,0.5), labels = c(0,0.1,0.2,0.3,0.4,0.5))
box()

# copy the plot to png file 
dev.copy(png, file = "plot4.png")
dev.off()

par(op)
