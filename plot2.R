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

# Making the 2nd plot
layout(matrix(1))
plot(Project_Assignment_data$Global_active_power, type = "l", 
     axes = FALSE,xlab = "",ylab = "Global Active Power(kilowatts)")

axis(1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(2)
box()

# copy the plot to png file 
dev.copy(png, file = "plot2.png")
dev.off()
