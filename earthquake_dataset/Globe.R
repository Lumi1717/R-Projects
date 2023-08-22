library(threejs)
library(flipChartBasics)
library(lubridate)

packages <- c("ggplot2", "ggmap", "ggsn", "dplyr", "lubridate", "sf", "spData", "tmap", "leaflet", "mapview", "animation", "gganimate", "ggthemes", "gifski", "av")
version <- lapply(packages, packageVersion)
version_c <- do.call(c, version)

# load your dataset
setwd("/Users/user/Desktop/Project")
quakes<-read.csv('2022_dataset.csv')

# make sure the data format is right
quakes$time <- ymd_hms(quakes$time)
quakes$updated <- ymd_hms(quakes$updated)
quakes$magType <- as.factor(quakes$magType)
quakes$net <- as.factor(quakes$net)
quakes$type <- as.factor(quakes$type)
quakes$status <- as.factor(quakes$status)
quakes$locationSource <- as.factor(quakes$locationSource)
quakes$magSource <- as.factor(quakes$magSource)
quakes <- arrange(quakes, -row_number())
# earthquakes dataset
earthquakes <- quakes %>% filter(type == "earthquake")

colors = as.numeric(quakes$depth)
palette = ChartColors(10, "red", reverse = TRUE)
colors = palette[colors]

# Plot the data on the globe
globejs(img = 'https://eoimages.gsfc.nasa.gov/images/imagerecords/73000/73909/world.topo.bathy.200412.3x5400x2700.jpg',
        lat = quakes$latitude,
        long = quakes$longitude,
        val =  2* ((quakes$depth)/4),
        color = colors,
        pointsize = 0.5,
        atmosphere = TRUE) 

