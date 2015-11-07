
plot3 <- function() {
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
    x$Date <- dmy(x$Date)

    # Filter data frame
    x <- x[x$Date >= ymd('2007-02-01') & x$Date <= ymd('2007-02-02'),]

    x$DateTime <- x$Date + hms(x$Time)
    
    # Convert to a DPLYR data frame - easier to view
    x <- tbl_df(x)
    

    # Open the PNG file and generate the plot    
    png(filename = "plot3.png")
    with (
        subset(x, x$Date >= ymd('2007-02-01') & x$Date <= ymd('2007-02-02')),
        plot(DateTime,
            Sub_metering_1,
            type="l",
            xlab = "",
            ylab = "Energy Sub Metering"
        )
    )

    with (
        subset(x, x$Date >= ymd('2007-02-01') & x$Date <= ymd('2007-02-02')),
        points(DateTime,
             Sub_metering_2,
             type="l",
             col="red"
        )
    )

    with (
        subset(x, x$Date >= ymd('2007-02-01') & x$Date <= ymd('2007-02-02')),
        points(DateTime,
               Sub_metering_3,
               type="l",
               col="blue"
        )
    )
    
    legend("topright", 
           legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"),
           lwd=2
    )
    
    
    dev.off()
    
    x
}

x<-plot3()