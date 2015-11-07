
plot4 <- function() {
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
    png(filename = "plot4.png")

        par(mfcol = c(2,2))
    
    # Plot #1 (top left)
    with (
        subset(x, x$DateTime >= ymd('2007-02-01') & x$DateTime < ymd('2007-02-03')),
        plot(DateTime,
             Global_active_power,
             type="l",
             xlab = "",
             ylab = "Global Active Power (kilowatts)"
        )
    )
    
    # Plot #2 (bottom left)
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
           lwd=2,
           bty="n"
    )

    # Plot #3 (top right)
    with (
        subset(x, x$Date >= ymd('2007-02-01') & x$Date <= ymd('2007-02-02')),
        plot(DateTime,
             Voltage,
             type="l"
        )
    )

    # Plot #4 (bottom right)
    with (
        subset(x, x$Date >= ymd('2007-02-01') & x$Date <= ymd('2007-02-02')),
        plot(DateTime,
             Global_reactive_power,
             type="l"
        )
    )
    
    
    dev.off()
    
    x
}

x<-plot4()