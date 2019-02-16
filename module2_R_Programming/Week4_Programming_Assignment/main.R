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

run <-function(){
        ## Get filePATH
        # file<-filepath("hospital-data")
        file<-filepath("outcome-of-care-measures")
        ## Read CSV
        outcome<-read.csv(file,colClasses = "character")
        head(outcome)

}
run()
