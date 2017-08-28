result <- GET("https://api.transport.nsw.gov.au/v1/roads/spatial?format=geojson&q=select%20*%20from%20road_traffic_counts_hourly_permanent%20where%20year%3D2017%20limit%2050",
              verbose(), 
              encode="json", 
              add_headers(`Authorization` = "apikey fUa8N1LC42AYtVDKIt6jbAzQXFPcf9b31GYv"))

content(result)
names(result)
result$status_code

head(result$content)
raw.content <- rawToChar(result$content)
nchar(raw.content)
substr(raw.content, 1, 100)
this.content <- fromJSON(raw.content)
class(this.content) #it's a list
length(this.content) 
API.Data <- as.data.frame(this.content)

