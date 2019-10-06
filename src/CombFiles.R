combineFiles=function(directory){
  suppressMessages(require(plyr))
  suppressMessages(require(data.table))
  i=1
  for(fls in list.files(directory)){
    fls_path = paste0(directory,fls)
    if(i==1){
      print(paste0("Reading file no ",i))
      df = fread(fls_path, stringsAsFactors = F, na.strings = c(NA, ""))
      df$FILE_NAME = fls
    }else{
      print(paste0("Reading and combining file no ",i, " with rest"))
      df_0 = fread(fls_path, stringsAsFactors = F, na.strings = c(NA, ""))
      df_0$FILE_NAME = fls
      df = rbind.fill(df, df_0)
    }
    i = i+1
  }
  return(df)
}
