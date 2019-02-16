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
        
        #filter to chosen state, Only look at specified state, so we only look at rows where contains specifified_state 
        data <-data[data$State == specified_state,]
        
        # filter to hospital name and columnes containing "Hospital.30.Day.Death ... . from specified outcome"
        # data <-select(data, Hospital.Name, colnames(data)[grep("Hospital.30.Day.Death",colnames(data))])
        sOut <- "Pneumonia";
        if(specified_outcome == "heart attack"){
                sOut <- "Heart.Attack"
        }else if(specified_outcome =="heart failure"){
                sOut <- "Heart.Failure"
        }
        filteredColumn<-paste("Hospital.30.Day.Death..Mortality..Rates.from",sOut,sep = ".")
        data <-select(data, Hospital.Name, filteredColumn)
        
        #replace not available -> NA
        data[,filteredColumn] <- gsub("Not Available", NA, data[,filteredColumn])
        #remove NA pairs
        data <- data[complete.cases(data),]
        #find where min is located
        minRow <- which.min(data[,filteredColumn])
        # print(minRow)
        bestResult <- data[minRow,]
        bestResult<-bestResult$Hospital.Name
        #return 
        bestResult
}
