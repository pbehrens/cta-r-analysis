library(ggplot2)
library("RPostgreSQL")
library(gtools)
averagetime <- function(stop.id, trips){
	one.stop <- na.omit(subset(trips, stop_id==stop.id))

	pred.time <- one.stop$prediction_generated
	exp.arrival <- one.stop$expected_arrival
		station.name <- one.stop$station_name[1]
		stop.direction <- one.stop$stop_desc[1]
		combined.name <- paste(station.name, stop.direction, sep=" ", collapse=NULL)
		if(combined.name == "NA NA"){
			return (c(NA, NA, NA))
		}

		diff <- difftime(exp.arrival, pred.time, unit="sec")
		avg <- mean(diff)
		avg <- round(avg / 60, digits = 3)
		one.stop.data <- c(stop.id, combined.name, avg)
		return (one.stop.data)
}

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="cta")
trips <- dbGetQuery(con,"select * from trips_trip")
# trips <- read.csv(file="../data/trips.csv", head=TRUE, sep=",", na.strings="")

# import the redline stops 
redline <- na.omit(read.csv(file="../data/redline.csv", head=FALSE, sep=",", na.strings="", stringsAsFactors=FALSE))
# set column names to something different than what was from the db dump
colnames(trips) <- c("id", "station_id","stop_id", "station_name","stop_desc","run_number",
"route_id","destination_id","destination_name","route_direction_code", "prediction_generated",
 "expected_arrival","is_approaching","is_scheduled","is_fit","is_delayed")

colnames(redline) <- c("stop_id", "direction_id", "stop_long_name", "lon", "lat", "station_name", "short_name", "parent_id")

# format the columns in each data frame to datatypes R can understand
# use posix data type rto store timestamp data
trips$prediction_generated <- as.POSIXlt(trips$prediction_generated, "%Y-%m-%d %H:%M:%S", tz="UTC")
trips$expected_arrival <- as.POSIXlt(trips$expected_arrival, "%Y-%m-%d %H:%M:%S", tz="UTC")
print(str(trips$station_name))
trips$station_name <- as.character(na.omit(trips$station_name))
trips$destination_name <- as.character(trips$destination_name)
trips$stop_desc <- as.character(trips$stop_desc)


redline$stop_long_name <- as.character(redline$stop_long_name)
redline$station_name <- as.character(redline$station_name)
redline$short_name <- as.character(redline$short_name)

# create data frame with dimensions of all the redline stops 
N <- length(redline$stop_id)
stop.ids <- redline$stop_id
stop.averages <- data.frame(stop_id=rep(NA, N), stop_name=rep("", N), avg=rep(NA, N), 
                 stringsAsFactors=FALSE)
# iterate through all of the stops and find the average time for a subset of the trips
for(i in 1:N) {	
	stop.id <- stop.ids[i]
	stop.row <- averagetime(stop.id, trips)
	stop.averages[i,] <- stop.row
}
complete.cases(stop.averages)
row.has.na <- apply(stop.averages, c(1,2), function(x){any(is.nan(x))})
sum(row.has.na)
stop.averages.filtered <- stop.averages[!row.has.na,]


head(stop.ids)
print(stop.averages)
# plot the average time for each L stop

ggplot(stop.averages.filtered, aes(x = stop_name, y = avg, width=.3)) +
geom_bar(colour="black", stat="identity", width=2, position="dodge") +
scale_x_discrete(labels = stop.averages$stop_name) +
scale_y_discrete(breaks = 1:10) +
opts(axis.text.y=theme_text(size=7))+
coord_flip()




