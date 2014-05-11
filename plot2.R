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
with(pdata,{
    Time = strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")
    plot(Time,as.numeric(Global_active_power),type="l",ylab="Global Active Power (kilowatts)",xlab="")
})


dev.copy(png,file="plot2.png",width = 480, height = 480, units = "px")
dev.off()