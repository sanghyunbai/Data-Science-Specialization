## The function reads theoutcome-of-care-measures.csvfile 
## and returns a character vectorwith  the  name  of  the  hospital  
## that  has  the  best  (i.e.   lowest)  30-day  mortality eg) (Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
## for  the  specified  outcomein that state.
## partial matching 
best <- function(specified_state,specified_outcome,data){
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
