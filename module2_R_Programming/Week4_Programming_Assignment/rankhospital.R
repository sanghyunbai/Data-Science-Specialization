## The rankhospital function
## return a character vector containing the name of the hospital 
## with the 5th lowest 30-day death ratefor heart failure. (if num = 5)
## Hospitals that do not have data on a particular outcome should be
## excluded from the set of hospitals when deciding the rankings.
## multiple hospitals have the same 30-day mortality rate for a given causeof death. 
## In those cases ties should be broken by using the hospital name
rankhospital <- function(specified_state,specified_outcome,num ="best",data){
        ## state = name of state
        ## specified_out come = result caused by c(heart attack,heart failure,pneumonia)
        ## num = can be “best”, “worst”,  or an integer 
        ## indicating the ranking(smaller numbers are better)
        ## data = dataset
        
        library(dplyr)
        #check if state is valid 
        if(!is.element(specified_state,data$State)){
                stop("invalid state")
        }
        #check if specified_outcome is valid 
        if (!is.element(specified_outcome,c("heart attack", "heart failure", "pneumonia"))) {
                stop('invalid outcome')
        }
        
        
}