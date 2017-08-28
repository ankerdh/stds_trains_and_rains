library(rgdal)
library(dplyr)
library(ggplot2)
library(ggmap)
install.packages("ggrepel")
library(ggrepel)

#Read in gbr.RData file

data2 <- list("index"=1:nrow(data), "feat"=data$FEAT_NAME, "name"=data$GBR_NAME, "lon"=data$X_COORD, "lat"=data$Y_COORD, "area"=data$Area_HA)
df <- as.data.frame(data2)

cays <- subset(df, feat=="Cay")
cays2 <- cays %>% filter(name!="U/N Cay")
sand <- subset(df, feat=="Sand")
reef <- subset(df, feat=="Reef")
bugatti <- subset(df, name=="Bugatti Reef")

gbr <- ggmap(get_googlemap(c(lon=149.41, lat=-19.72), zoom=8, maptype="hybrid", size=c(600,320)))

gbr+
  geom_point(aes(x=lon, y=lat), data=cays, colour="red") +
  geom_point(aes(x=lon, y=lat), data=bugatti, colour="yellow") +
  geom_text_repel(aes(label=name), data=bugatti, colour="white", size=3) +
  geom_text_repel(aes(label=index), data=cays, colour="white", size=3)
