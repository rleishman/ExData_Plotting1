
plot2 <- function() {
    library(lubridate)
    library(dplyr)
    
    # Read in the file
    x <- read.table(
            "household_power_consumption.txt", 
            header=TRUE, 
            na.strings="?", 
            stringsAsFactors = FALSE,
            sep = ";")
    
    # Convert Date and Time
    x$DateTime <- dmy(x$Date) + hms(x$Time)
    
    # Convert to a DPLYR data frame - easier to view
    x <- tbl_df(x)
    

    # Open the PNG file and generate the plot    
    png(filename = "plot2.png")
    with (
        subset(x, x$DateTime >= ymd('2007-02-01') & x$DateTime < ymd('2007-02-03')),
        plot(DateTime,
            Global_active_power,
            type="l",
            xlab = "",
            ylab = "Global Active Power (kilowatts)"
        )
    )
    dev.off()
    
    x
}

x<-plot2()