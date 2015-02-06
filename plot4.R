#read full data#
fulldata<-read.table("exdata-data-household_power_consumption/household_power_consumption.txt",
                     sep = ";", header=TRUE, na.strings = "?"  )

#change format to variable date## 
fulldata$Date<-as.Date(fulldata$Date,"%d/%m/%Y")

#subset data#
data<-fulldata[fulldata["Date"]== "2007-02-01"|fulldata["Date"]== "2007-02-02",]
#create new variable#
data$datetime<-with(data,paste(Date, Time))
library(lubridate)
data$datetime<-as.POSIXlt(ymd_hms(data$datetime))


#my rstudio is in spanish, so the names of the weekdays in the plot are in spanish#

#fourth plot#
png(filename="plot4.png", width=480, height= 480 )

op<-par(no.readonly=TRUE)
par(mfrow=c(2,2))
with(data,plot(datetime,Global_active_power,type="l", xlab="",
               ylab="Global Active Power (Kilowatts)") )
with(data,plot(datetime,Voltage,type="l",ylab="Voltage") )
with(data,plot(datetime,Sub_metering_1, type="l",xlab=""))
with(data,lines(datetime,Sub_metering_2,col="red"))
with(data,lines(datetime,Sub_metering_3,col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd= 1,col=c("black","red","blue"),cex=0.9,bty="n" )
with(data,plot(datetime,Global_reactive_power,type="l",
               ylab="Global_reactive_power") )
par(op)

dev.off()
