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


#first plot#
png(filename="plot1.png", width=480, height= 480 )

hist(data$Global_active_power,main = "Global Active Power",
     xlab="Global active power (Kilowatts)",col="red",cex.lab=0.8,cex.main=1)
dev.off()

