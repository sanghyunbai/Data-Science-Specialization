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
        
        ## Find best hospital in a state.
        source(filepath("best",dirPath(),"R"))
        best("TX","heart attack1",outcome)
        best("TX1","heart attack",outcome)
}
run()
