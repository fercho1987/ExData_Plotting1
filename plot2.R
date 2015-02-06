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

#second plot#
png(filename="plot2.png", width=480, height= 480 )
with(data,plot(datetime,Global_active_power,type="l", xlab="",
               ylab="Global Active Power (Kilowatts)",,cex.lab=0.8) )
dev.off()
