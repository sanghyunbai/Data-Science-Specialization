## The function reads theoutcome-of-care-measures.csvfile 
## and returns a 2-column data framecontaining the hospital in each state 
## that has the ranking specified in num.  
## For example the function callrankall("heart attack", "best")
## would return a data frame containing the names of the hospitals 
## that are the best in their respective states for 30-day heart attack death rates.  
## The function should return a valuefor every state (some may be NA)
## Handling ties.  Therankallfunction should handle ties in the 30-day mortality rates 
## in the same way that therankhospitalfunction handles ties.

rankall <- function(specified_outcome, num="best"){
        #check if specified_outcome is valid 
        if (!is.element(specified_outcome,c("heart attack", "heart failure", "pneumonia"))) {
                stop('invalid outcome')
        }
        
}