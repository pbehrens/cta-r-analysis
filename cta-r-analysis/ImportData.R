average.monthly <- read.csv(file="./data/cta_ridership_average_monthly.csv", head=TRUE, sep=",")
daily.boarding <- read.csv(file="./data/cta_ridership_daily_boardings.csv", head=TRUE, sep=",")
daily.totals <- read.csv(file="./data/cta_ridership_daily_totals.csv", head=TRUE, sep=",")
red.line <- read.csv(file="data/redline.csv", head=FALSE, sep=",")
trips <- read.csv(file="data/trips.csv", head=TRUE, sep=",")

# colnames(red.line) <- c("stop_id", "direction_id", "stop_long_name", "lon", "lat", "station_name", "short_name", "parent_id")

print(head(trips))




