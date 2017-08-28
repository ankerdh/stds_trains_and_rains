eag.neac_dsd <- readSDMX(#we are going to use the same parameters as we filtered on to get the direct url - make sure you can see how it all came out
  providerId ="roads", 
  resource ="data", 
  flowRef ="EAG_NEAC",
  key ="fUa8N1LC42AYtVDKIt6jbAzQXFPcf9b31GYv", 
  key.mode ="SDMX",
  start =1981,  
  end =2015, 
  dsd =TRUE) #this is where we say we want the data definition


library(rsdmx)
key <- "&apikey=fUa8N1LC42AYtVDKIt6jbAzQXFPcf9b31GYv"
url<-"https://api.transport.nsw.gov.au/v1/roads/spatial?format=geojson&q=select%20*%20from%20road_traffic_counts_station_reference%20limit%2050%20"
URL<-"https://api.transport.nsw.gov.au/v1/roads/spatial?format=geojson&apikey=fUa8N1LC42AYtVDKIt6jbAzQXFPcf9b31GYv&q=select%20*%20from%20road_traffic_counts_station_reference%20limit%2050%20"
Traffic.data <- fromJSON(paste0(url,key))
Traffic <- as.data.frame(eag.neac)
Traffic

drone_bills <- fromJSON(paste0("http://openstates.org/api/v1/bills/?q=drone", key))
drone_bills$title <- substring(drone_bills$title, 1, 40)
print(drone_bills[1:5, c("title", "state", "chamber", "type")])

library(jsonlite)


GET(url = url,
    verbose(),
    add_headers(app_key = key, 'Accept' = "application/json")
    )


url <- "https://api.transport.nsw.gov.au/v1/roads/spatial/?format=geojson&q=select%20*%20from%20road_traffic_counts_station_reference%20limit%2050%20"
path <- "format=geojson&q=select%20*%20from%20road_traffic_counts_station_reference%20limit%2050%20"
key <- "fUa8N1LC42AYtVDKIt6jbAzQXFPcf9b31GYv"
curl -X GET --header 'Accept: application/json' --header 'Authorization: apikey fUa8N1LC42AYtVDKIt6jbAzQXFPcf9b31GYv' 'https://api.transport.nsw.gov.au/v1/roads/spatial?format=geojson&q=select%20*%20from%20road_traffic_counts_station_reference%20limit%2050%20'