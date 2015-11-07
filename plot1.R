
plot1 <- function() {
    library(lubridate)
    library(dplyr)
    
    # Read in the file
    x <- read.table(
            "household_power_consumption.txt", 
            header=TRUE, 
            na.strings="?", 
#            nrows=100000,
            stringsAsFactors = FALSE,
            sep = ";")
    
    # Convert Date and Time
    x$Date <- dmy(x$Date)
    x$Time <- hms(x$Time)
    
    # Convert to a DPLYR data frame - easier to view
    x <- tbl_df(x)
    
    # Open the PNG file and generate the saved histogram    
    png(filename = "plot1.png")
    with (
        subset(x, x$Date >= ymd('2007-02-01') & x$Date <= ymd('2007-02-02')),
        hist(Global_active_power,
            main = "Global Active Power",
            xlab = "Global Active Power (kilowatts)",
            col="red")
    )
    dev.off()
}

plot1()