install.packages("rgdal")
library(rgdal)
library(ggmap)
library(dplyr)
data<-readOGR(dsn="C:/Users/David Anker/Documents/MDSI/36103 Statistical Thinking for Data Science/GBR/zipfolder",layer="Great_Barrier_Reef_Features")
cays <- subset(data, data$FEAT_NAME == "Cay")
sand <- subset(data,data$FEAT_NAME == "Sand")
lon <- cays$X_COORD
lat <- cays$Y_COORD
data2 <- list("lon"=lon, "lat"=lat)
data3 <- as.data.frame(data2)
data4 <- data3 %>% mutate(name=cays$LOC_NAME_L)

gbr <- c(lon=149.3, lat=-19.5)
gbr_map <- get_map(location=gbr, zoom=8, maptype="terrain")
ggmap(gbr_map)+
  geom_point(aes(lon, lat), colour="red", data=data3) +
  geom_text(aes(label=lon), hjust=0, vjust=1.5, data=data4) +
  geom_text(aes(label=lat), hjust=0, vjust=0.5, data=data4)

str(data)
summary(data)


cars<-mtcars
