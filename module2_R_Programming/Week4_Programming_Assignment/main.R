## Function constructs filePath
filepath <- function(filename){
        #construct path 
        csvFile <- paste(filename,"csv",sep = ".")
        currentpath <- getwd()
        pathToDirectory <- paste(currentpath,"module2_R_Programming","Week4_Programming_Assignment","HospitalDataSet",sep = "/")
        if(dir.exists(pathToDirectory)){
                pathToFile <- paste(pathToDirectory,csvFile,sep = "/")
                if(file.exists(pathToFile)){
                        return(pathToFile)
                }else{
                        stop("file dose not exist")
                }
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
        ## Get filePATH
        # file<-filepath("hospital-data")
        file<-filepath("outcome-of-care-measures")
        ## Read CSV
        outcome<-read.csv(file,colClasses = "character")
        
        ## Structure check 
        # structureCheck(outcome)
        
        ##Simple histogram
        simpleHisto(outcome)
}
run()
