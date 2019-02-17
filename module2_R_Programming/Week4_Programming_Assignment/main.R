## Function constructs filePath
filepath <- function(filename,pathToDirectory,compiler){
        #construct path 
        csvFile <- paste(filename,compiler,sep = ".")
        pathToFile <- paste(pathToDirectory,csvFile,sep = "/")
        if(file.exists(pathToFile)){
                return(pathToFile)
        }else{
                stop("file dose not exist")
        }
}
dirPath <- function(directory= NULL){
        currentpath <- getwd()
        pathToDirectory <- paste(currentpath,"module2_R_Programming","Week4_Programming_Assignment",sep = "/")
        if(!is.null(directory)){
                pathToDirectory <- paste(pathToDirectory,directory,sep = "/")
        }
        if(dir.exists(pathToDirectory)){
                return(pathToDirectory)
        }else{
                stop("directory does not exist")
        }       
}
## Function prints info about the dataset
structureCheck <- function(data){
        # print(head(data))
        # print(ncol(data)) #Check num columns
        print(names(data)) #Check names of columns
        # print(row.names(data)) #Check names of rows
        # str(data)
        # summary(data)
        # print(data$State)
}

simpleHisto <- function(data){
        #Histogram of 30-day deaths rates from heart attack
        # outcome[,11] is not numeric because when we read csv,
        # we specified colClasses="character"
        # ignore the waring regarding NA for now 
        if(!is.numeric(data[,11])){
          data[,11] <- as.numeric(data[,11])
        }
        hist(data[,11], main = "simple histogram of the 30-day death rates from heart attack ")
}
run <-function(){
        ## Get directory PATH
        dir<-dirPath("HospitalDataSet")
        ## Get filePATH
        # file<-filepath("hospital-data")
        file<-filepath("outcome-of-care-measures",dir,"csv")
        ## Read CSV
        outcome<-read.csv(file,colClasses = "character")
        
        ## Structure check 
        # structureCheck(outcome)
        
        ##Simple histogram
        # simpleHisto(outcom)
        
        ## Part2; Find best hospital in a state.
        # source(filepath("best",dirPath(),"R"))
        # #test 0
        # # best("TX","heart attack1",outcome)
        # # best("TX1","heart attack",outcome)
        # # best("BB", "heart attack",outcome)
        # # best("NY", "hert attack",outcome)
        # #test 1
        # print("Expected:CYPRESS FAIRBANKS MEDICAL CENTER")
        # print(paste("Result  ",best("TX","heart attack",outcome),sep = ":"))
        # #test 2
        # print("Expected:FORT DUNCAN MEDICAL CENTER")
        # print(paste("Result  ",best("TX", "heart failure",outcome),sep = ":"))
        # #test 3
        # print("Expected:JOHNS HOPKINS HOSPITAL, THE")
        # print(paste("Result  ",best("MD", "heart attack",outcome),sep = ":"))
        # #test 4
        # print("Expected:GREATER BALTIMORE MEDICAL CENTER")
        # print(paste("Result  ",best("MD", "pneumonia",outcome),sep = ":"))
        
        # ## Part3; Rank hospitals 
        # source(filepath("rankhospital",dirPath(),"R"))
        # # #test 0
        # #  rankhospital("TX1","heart failure",4,outcome)
        # #  rankhospital("TX","heart failure1",4,outcome)
        # #test 1 
        # print("Expected:DETAR HOSPITAL NAVARRO")
        # print(paste("Result  ",rankhospital("TX","heart failure", num=4,outcome),sep = ":"))
        # #test 2
        # print("Expected:HARFORD MEMORIAL HOSPITAL")
        # print(paste("Result  ",rankhospital("MD","heart attack", num="worst",outcome),sep = ":"))
        # #test 3       
        # print("Expected:NA")
        # print(paste("Result  ",rankhospital("MN","heart attack", num=5000,outcome),sep = ":"))
        
        ## Part4; Rank hospitals for all states
        source(filepath("rankall",dirPath(),"R"))
        # #test 0
        # rankall("heart attack",20,outcome)
        # test 1
        head(rankall("heart attack", 20,outcome), 10)
        # test 2
        # tail(rankall("pneumonia", "worst",outcome), 3)
        # test 3
        # tail(rankall("heart failure",data=outcome), 10)
}
run()
