#This R Script will read in the rollingsales_manhattan.xls file and clean it to remove leading digits, format data to their
#proper types, remove null values, remove outliers, and finally create a new dataframe of sold family dwellings.

require(plyr)
require(gdata)
library(plyr)
library(gdata)

#read in dataframe and convert to values to string
manhattansales <- read.xls("rollingsales_manhattan.xls", pattern ="BOROUGH")
str(manhattansales)

#convert variable SALE.PRICE from factor into numeric and get rid off of leading digits
manhattansales$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", manhattansales$SALE.PRICE))

#make all variable names lower case
names(manhattansales) <- tolower(names(manhattansales))

#convert other numeric variables, as well as, date variables
manhattansales $ gross.sqft <- as.numeric(gsub("[^[:digit:]]","", manhattansales $ gross.square.feet))
manhattansales$land.sqft <- as.numeric(gsub("[^[:digit:]]","", manhattansales $ land.square.feet))
manhattansales$sale.date <- as.Date(manhattansales$sale.date)
manhattansales$year.built <- as.numeric(as.character(manhattansales$year.built))
str(manhattansales)

#select actual sales of family homes only
manhattansales.sale <- manhattansales[manhattansales$sale.price.n!=0,]
manhattansales.homes <- manhattansales.sale[which(grepl("FAMILY", manhattansales.sale$building.class.category)),]
summary(manhattansales.homes)

#remove outliers
manhattansales.homes$outliers <- (log10(manhattansales.homes$sale.price.n) <=5) + 0
manhattansales.homes <- manhattansales.homes[which(manhattansales.homes$outliers == 0),]