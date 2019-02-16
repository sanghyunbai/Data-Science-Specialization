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
        
        #filter to chosen state, Only look at specified state, so we only look at rows where contains specifified_state 
        data<-filter(data,data$State == specified_state)
        
        # filter to hospital name and columnes containing "Hospital.30.Day.Death ... . from specified outcome"
        # select columns containing name : Hospital.Name, pattern of "hospital.30.day.death" 
        # check grep();  print lines matching a pattern # also check linux command grep()
        # Generally PCRE will be faster than the default regular expression engine, and 
        # fixed = TRUE faster still (especially when each pattern is matched only a few times) 
        data <-select(data, Hospital.Name, colnames(data)[grep("Hospital.30.Day.Death",colnames(data))])
        
        #filter again to specified_outcome
        sOut <- "Pneumonia";
        if(specified_outcome == "heart attack"){
                sOut <- "Heart.Attack"
        }else if(specified_outcome =="heart failure"){
                sOut <- "Heart.Failure"
        }
        data <-select(data, Hospital.Name, colnames(data)[grep(sOut,colnames(data))])
        # head(data)
        
        # Exclude columns containing Footnote, Patients,Upper,Lower,Comparison
        check <- colnames(data)[grep("Footnote|Patients|Lower|Upper|Comparison",colnames(data))] 
        data<- select(data, -check)
        
        #rename col2
        colnames(data)[2] <- "DeathRate"        
        # Substitute "Not Avaiable" to NA
        data$DeathRate <- gsub("Not Available", NA, data$DeathRate)
        if(!is.numeric(data$DeathRate)){
                data$DeathRate <- as.numeric(as.character(data$DeathRate))
        }

        # Discard NA 
        completedData <-data[complete.cases(data),]

        # Sort by # Death Rate (Ascending) & Name (Ascending) 
        sortedIndex <-order(completedData$DeathRate, completedData$Hospital.Name)
        sortedData<-completedData[sortedIndex, ]

        #Check what row is needed
        if(num == "worst"){
                # print("worst")
                num <-nrow(sortedData)
        }else if(num == "best"){
                # print("best")
                num <-1
        }
        
        #RETURN
        sortedData[num, "Hospital.Name"]
}