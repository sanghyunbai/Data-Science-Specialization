## The function reads theoutcome-of-care-measures.csvfile 
## and returns a 2-column data frame containing the hospital in each state 
## that has the ranking specified in num.  
## For example the function callrankall("heart attack", "best")
## would return a data frame containing the names of the hospitals 
## that are the best in their respective states for 30-day heart attack death rates.  
## The function should return a valuefor every state (some may be NA)
## Handling ties.  Therankallfunction should handle ties in the 30-day mortality rates 
## in the same way that therankhospitalfunction handles ties.

rankall <- function(specified_outcome, num="best", data){
         
        #check if specified_outcome is valid 
        if (!is.element(specified_outcome,c("heart attack", "heart failure", "pneumonia"))) {
                stop('invalid outcome')
        }
        
        # Filter datasets
        data <-select(data, Hospital.Name, State,colnames(data)
                      [grep("Hospital.30.Day.Death",colnames(data))])

        # Exclude all columnes except Hospitals.Name & ...Death..Rate for all groups
        # so exclude Footnote, Patients,Upper,Lower,Comparison
        removeColumns <- colnames(data)[grep("Footnote|Patients|Lower|Upper|Comparison"
                                     ,colnames(data))] 
        relevantData<- select(data, -removeColumns)
        
        #filter to specified_outcome
        sOut <- "Pneumonia";
        if(specified_outcome == "heart attack"){
                sOut <- "Heart.Attack"
        }else if(specified_outcome =="heart failure"){
                sOut <- "Heart.Failure"
        }
        relevantData <-select(relevantData, Hospital.Name, State
                              ,colnames(relevantData)[grep(sOut,colnames(relevantData))])

        # rename columne 3 ....Mortality....
        colnames(relevantData)[3] <- "MortalityRate"        
        
        # Substitute "Not Avaiable" to NA
        relevantData$Hospital.Name <- gsub("Not Available", NA, relevantData$Hospital.Name)
        relevantData$MortalityRate <- gsub("Not Available", NA, relevantData$MortalityRate)
        if(!is.numeric(relevantData$DeathRate)){
                relevantData$MortalityRate <- as.numeric(as.character(relevantData$MortalityRate))
        }

        # Discard NA 
        # relevantData <-relevantData[complete.cases(relevantData),]
        
        # Grouping data into state
        splittedData<-split(relevantData,relevantData$State)
        # print(str(relevantData)) # relevantData = list, which each element is data.frame of 3 variables i.e name,state,Rate
        # every element in list, df.
        # Sort function needs to be applied to every vectors in each df.
        # Sort by # Death Rate (Ascending) & Name (Ascending)
        sortedGroupData <-lapply(splittedData, function(df)
                df[order(df$MortalityRate,df$Hospital.Name,na.last = NA),])

        # TAKE the given ranked (defined in num) hospital (best = first row) from every state
        # print(str(sortedGroupData))
        rankedHospitals <- lapply(sortedGroupData, function(dataFrames)
                dataFrames[num,])
         
        # merge the splited groups into One 
        # print(str(bestHospitals))
        # resultDataSet<-rbindlist(rankedHospitals)
        # print(str(resultDataSet))
        resultDataSet<- data.frame()
        for(i in rankedHospitals){
                resultDataSet<-rbind(resultDataSet,i)
        }
         
        #best of best OR rank of rank
        # Sort by # Death Rate (Ascending) & Name (Ascending) 
        # sortedIndex <-order(resultDataSet$MortalityRate, resultDataSet$Hospital.Name)
        # sortedData<-resultDataSet[sortedIndex, ]
        # print(sortedData)
        resultDataSet[,1:2]
}