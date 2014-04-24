
run_analysis  <- function(directoryPath)
{
  
  library(sqldf)
  
  
  testX <- read.table (paste(directoryPath,"X_test.txt",sep=""),sep=" ")
  trainX <- read.table (paste(directoryPath,"X_train.txt",sep=""),sep=" ")
  testY <- read.table(paste(directoryPath,"Y_test.txt",sep=""),sep=" ")
  trainY <- read.table(paste(directoryPath,"Y_train.txt",sep=""),sep=" ")
  activityLabels <- read.table(paste(directoryPath,"activity_labels.txt",sep=""),sep=" ")
  
  subjectTest <- read.table(paste(directoryPath,"subject_test.txt",sep=""),sep=" ")
  subjectTrain <-read.table(paste(directoryPath,"subject_train.txt",sep=""),sep=" ")
  
  featureDF <- read.table(paste(directoryPath,"features.txt", sep=""),sep=" ")
  meanStdData<-sqldf("select * from featureDF where v2 like '%mean()%' or v2 like '%std()%'")
  
  
  
  #trainX <- rbind(testX, trainX)
  combinedRaw <- rbind(testX, trainX)
  
  
  trainY <- rbind(testY, trainY)  
  activitiesDF<-sqldf("select trainY.V1,activityLabels.V2 from trainY, activityLabels where activityLabels.V1 = trainY.V1")
  
  
  subjectTrain<-rbind(subjectTest,subjectTrain)
  
  #trainX["trainY"] <- trainY
  
 
  
  #CleanedUpDS["activity_code"] <- activitiesDF$V1
  #combinedRaw["activity"] <- activitiesDF$V2
  
  CleanedUpDS <- combinedRaw
  CleanedUpDS["Subject"] <- subjectTrain
  CleanedUpDS["Activity_Code"] <- activitiesDF$V1
  CleanedUpDS["Activity"] <- activitiesDF$V2
  
  #meanStdData$V1<-paste('V',meanStdData$V1,sep="")
  
    #colnames(rows)[which(names(rows) == colName)] <- sqldf(paste("select V2 from meanStdData where V1=",i,sep=""))
 
      extractedDF <- data.frame(col="")
    
      for(i in meanStdData$V1)
      {
        colName <- paste('V',i,sep="")
        rows<-CleanedUpDS[colName]        
        modifiedColName <-levels(factor(subset(featureDF[['V2']], featureDF[['V1']]==i)))                
        colnames(rows)[1]<-modifiedColName                
        extractedDF <- cbind(extractedDF, rows)      
      }
  
  extractedDF$col <- NULL
  
  colnames(activitiesDF)[1]<- 'Activity_Code'
  colnames(activitiesDF)[2]<- 'Activity'
  colnames(subjectTrain)[1]<-'Subject'
  
  FilteredDS <- activitiesDF
  
  FilteredDS <- cbind(subjectTrain,FilteredDS,extractedDF)
  tidyDS<-data.frame(Means=rowMeans(combinedRaw[,-1]))
  tidyDS<- cbind(subjectTrain, activitiesDF, tidyDS)
  tidyDS<-sqldf("Select Subject,Activity_Code,Activity, Avg(Means) Average from tidyDS group by Subject,Activity_Code,Activity ")
  
  
  #write.csv(tidyDS, "TidyData.csv")
  
  sidname <- c("'See Combined RAW data set' ",               
               "'Extracted data for mean and standard deviation for each measurement. '",
               "'Complete Ds with descriptive activity names'",
               "'Filtered Ds with desciptive names'",
               "'Tidy Data set with Average values'"
               
  )
  numparts <- length(sidname)
  cat(paste(paste("[", seq_len(numparts), "]", sep = ""), sidname),
      sep = "\n")
  partnum <- readline(sprintf("Enter your choice: [1-%d]? ",
                              numparts))
  partnum <- as.integer(partnum)
  if(is.na(partnum))
    stop("please specify part number")
  if(partnum > numparts)
    stop("invalid part number")
  
  if (partnum==1) combinedRaw
  else if (partnum==2) print(meanStdData)
  else if (partnum==3) print(CleanedUpDS)
  else if (partnum==4) print(FilteredDS)
  else if (partnum==5) print((tidyDS))
   
  
}
