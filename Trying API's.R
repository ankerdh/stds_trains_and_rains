install.packages("httr")
?httr
library(httr)
library(jsonlite)
library(lubridate)
options(stringsAsFactors = FALSE)
url  <- "http://api.epdb.eu"
path <- "eurlex/directory_code"
raw.result <- GET(url = url, path = path)
names(raw.result)
raw.result$status_code
head(raw.result$content)
this.raw.content <- rawToChar(raw.result$content)
nchar(this.raw.content)
substr(this.raw.content, 1, 100)
this.content <- fromJSON(this.raw.content)
class(this.content) #it's a list
length(this.content) #it's a large list
this.content[[1]] #the first element
this.content[[2]] #the second element
## This function takes a thing (args) and does something to it (what). 
## In this case each list in the BIG list is turned into a data frame (lapply) then rbinded one on top of the other.
this.content.df <- do.call(what = "rbind",
                           args = lapply(this.content, as.data.frame))
## 
class(this.content.df) #a single data frame
dim(this.content.df)   #with 462 rows and 4 variables
head(this.content.df)
headClass <- substr(x     = this.content.df[, "directory_code"],
                    start = 1,
                    stop  = 2)
length(headClass)
head(headClass)
isEnergy <- headClass == "12"
table(isEnergy) # 19 of the topic classifiers start with 12
relevant.df <- this.content.df[isEnergy, ]
relevant.dc <- relevant.df[, "directory_code"]
length(relevant.dc)
relevant.dc
makeQuery <- function(classifier) {
  this.query <- list(classifier)
  names(this.query) <- "dc"
  return(this.query)
}
makeQuery("foo")
queries <- lapply(as.list(relevant.dc), makeQuery)
this.raw.result <- GET(url = url, path = path, query = queries[[1]])
this.result <- fromJSON(rawToChar(this.raw.result$content))
names(this.result[[1]])
all.results <- vector(mode   = "list",
                      length = length(relevant.dc))
for (i in 1:length(all.results)) {
  this.query       <- queries[[i]]
  this.raw.answer  <- GET(url = url, path = path, query = this.query)
  this.answer      <- fromJSON(rawToChar(this.raw.answer$content))
  all.results[[i]] <- this.answer
  message(".", appendLF = FALSE)
  Sys.sleep(time = 1)
}
parseAnswer <- function(answer) {
  this.form   <- answer$form
  this.date   <- answer$date
  this.effect <- answer$of_effect
  result <- data.frame(form   = this.form,
                       date   = this.date,
                       effect = this.effect)
  return(result)
}
parseAnswer(all.results[[1]][[2]])
parsedAnswers <- lapply(all.results,
                        function(x) do.call("rbind", lapply(x, parseAnswer)))
class(parsedAnswers) #list
length(parsedAnswers) #19
sapply(parsedAnswers, nrow) #11, 15, 107, ...
finalResult <- do.call("rbind", parsedAnswers)
class(finalResult) #data.frame


?GET
