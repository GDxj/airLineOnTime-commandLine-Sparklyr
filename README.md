# airLineOnTime-commandLine-Sparklyr

- Data Source: https://packages.revolutionanalytics.com/datasets/AirOnTime87to12/
- Work with csv using Command Line: https://bconnelly.net/posts/working_with_csvs_on_the_command_line/

## some notes:
  1. Command Line is capable to inspect the headers of csv and merge multiple csvs into a combined one (by doing this we do not need to import csv into R before merging it)
  
    - inspect: head -5 airOT198710.csv
    
    - copy header to new csv: head -1 airOT198710.csv > combined.csv
    
    - merge: for file in $(ls airOT*); do cat $file | sed "1 d" >> combined.csv; done
    
  2. sparkly uses lazy query that the manipulation part (pipes) is not done until we use it. 
    - to speed it up we can use 'collect' then 'readRDS' to save it to disk

## future goals:
  1. fit a simple ml model to predict delay or not
  2. fit a time series model on mean delay time each day over the 30 years
