## load libraries
library(sparklyr)
library(tidyverse)
library(lubridate)

## define spark connection
sc = spark_connect(master = "local")

## load the combined data in R
setwd('C:/Users/gdong/Desktop/GiganticCsv/AirOnTimeCSV')
air = spark_read_csv(sc, name = "air", path = "combined.csv")

## mean delay time at departure per day
tic = Sys.time()
mean_dep_delay = air %>%
  group_by(YEAR, MONTH, DAY_OF_MONTH) %>%
  summarise(mean_delay = mean(DEP_DELAY))
(toc = Sys.time() - tic)
# Time difference of 0.006980896 secs

## Display means
head(mean_dep_delay)

## transfer Spark object into R using 'collect'
tic = Sys.time()
r_mean_dep_delay = collect(mean_dep_delay)
(toc = Sys.time() - tic)
# Time difference of 2.429201 mins

## save it to disk as it is very slow
saveRDS(r_mean_dep_delay, "mean_dep_delay.rds")

## visualization mean delay vs date
dep_delay =  r_mean_dep_delay %>%
  arrange(YEAR, MONTH, DAY_OF_MONTH) %>%
  mutate(date = ymd(paste(YEAR, MONTH, DAY_OF_MONTH, sep = "-")))

ggplot(dep_delay, aes(date, mean_delay)) + geom_smooth()


## machine learning
data_ml <- air %>% 
  filter(YEAR >= 2012) 

r_data_ml <- collect(data_ml)

saveRDS(r_data_ml, "r_data_ml.rds")


