if (require(data.table)==FALSE) install.packages("data.table")

library(data.table)


# using fread to read the whole file
DT = fread("household_power_consumption.txt",na.strings="?")

# transform to the Date format
DT = within(DT,{Date=as.Date(Date,"%d/%m/%Y")})

# subsetting the data
datesub=as.Date(c("1/2/2007","2/2/2007"),"%d/%m/%Y")

pdata = subset(DT,DT$Date>=datesub[1] & DT$Date<=datesub[2])

# line plotting and saving as png

png(filename="plot4.png",width = 480, height = 480, units = "px")

par(mfcol=c(2,2))

with(pdata,{
    Time = strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")
    plot(Time,as.numeric(Global_active_power),type="l",ylab="Global Active Power (kilowatts)",xlab="")
})


with(pdata,{
    Time = strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")
    plot(Time,as.numeric(Sub_metering_1),type="n",ylab="Energy sub metering",xlab="")
    lines(Time,as.numeric(Sub_metering_1),col="black")
    lines(Time,as.numeric(Sub_metering_2),col="red")
    lines(Time,as.numeric(Sub_metering_3),col="blue")
    legend("topright", col=c("black","red","blue"),lty=1,bty="n",cex=0.5,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})


with(pdata,{
    Time = strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")
    plot(Time,as.numeric(Voltage),type="l",ylab="Voltage",xlab="datetime")
})


with(pdata,{
    Time = strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")
    plot(Time,as.numeric(Global_reactive_power),type="l",ylab="Global_reactive_power",xlab="datetime")
})

dev.off()

# dev.copy(png,file="plot4.png",width = 480, height = 480, units = "px")
# dev.off()