dataSnapshot = function(df){
  suppressMessages(library(data.table))
  data.table(
    ColumnNames=names(df),
    Class=sapply(df, class),
    NaCount=sapply(df, function(x) sum(is.na(x))),
    NaPerc=round((sapply(df, function(x) sum(is.na(x)))/nrow(df))*100, 2),
    SampleData=apply(apply(sapply(df, head,3), 1, paste, sep = ","), 1, paste, collapse=","),
    UniqueCount=sapply(df, function(x) length(unique(x))),
    UniqueTop3=apply(dat, 2, function(x) {
      tmp=as.data.table(table(x, useNA = "ifany"))
      tmp=tmp[order(tmp$N, decreasing = T),]
      tmp=as.data.frame(tmp)
      if(nrow(tmp)>2){
        tmp = as.character(tmp[1:3,1])
      }else{
        tmp = as.character(tmp[,1])
      }
      paste(trimws(tmp), collapse = ",")
    }),
    UniqueTop3Count=apply(dat, 2, function(x) {
      tmp=as.data.table(table(x, useNA = "ifany"))
      tmp=tmp[order(tmp$N, decreasing = T),]
      tmp=as.data.frame(tmp)
      if(nrow(tmp)>2){
        tmp = as.character(tmp[1:3,2])
      }else{
        tmp = as.character(tmp[,2])
      }
      paste(trimws(tmp), collapse = ",")
    })
  )
}

