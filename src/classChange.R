classChange = function(df, df_snap=NULL){
  # df = dat
  # df_snap = dat_snap
  # df_snap = NULL
  # column="Name"
  # rm(df, df_snap, column)
  
  suppressMessages(require(svDialogs))
  suppressMessages(require(parsedate))
  
  class_selection = character()
  result_all = character()
  
  for(column in names(df)){
    if(is.null(df_snap)){
      print(paste0("Select a class for ", column))
    }else{
      print(paste0("Select a class for ", column, " : ",
                   "Unique Count " ,df_snap$UniqueCount[df_snap$ColumnNames==column], " : ",
                   "Unique Top3 " ,df_snap$UniqueTop3[df_snap$ColumnNames==column], " : ",
                   "Unique Top3 Count " ,df_snap$UniqueTop3Count[df_snap$ColumnNames==column], " : ",
                   "NA Count " ,df_snap$NaCount[df_snap$ColumnNames==column], " : ",
                   "Total Observations ", nrow(df)))
    }
    
    class_change = svDialogs::dlg_list(choices = c("integer","character","numeric", "factor", "date"),
                                       title=paste0("Class for ",column))$res
    class_selection = c(class_selection, class_change)
    if(class_change=="integer"){
      result = tryCatch({
        df[[column]] = as.integer(df[[column]])
        "successfully converted"
      }, warning = function(w) {
        "Unsuccessful, check data"
      }, error = function(e) {
        "Can not be converted to integer, check data"
      })
    }
    if(class_change=="character"){
      result = tryCatch({
        df[[column]] = as.character(df[[column]])
        "successfully converted"
      }, warning = function(w) {
        "Unsuccessful, check data"
      }, error = function(e) {
        "Can not be converted to character, check data"
      })
    }
    if(class_change=="numeric"){
      result = tryCatch({
        df[[column]] = as.numeric(df[[column]])
        "successfully converted"
      }, warning = function(w) {
        "Unsuccessful, check data"
      }, error = function(e) {
        "Can not be converted to numeric, check data"
      })
    }
    if(class_change=="factor"){
      result = tryCatch({
        df[[column]] = as.factor(df[[column]])
        "successfully converted"
      }, warning = function(w) {
        "Unsuccessful, check data"
      }, error = function(e) {
        "Can not be converted to factor, check data"
      })
    }
    if(class_change=="date"){
      result = tryCatch({
        df[[column]] = parse_date(df[[column]])
        "successfully converted to date"
      }, warning = function(w) {
        "Unsuccessful, check data"
      }, error = function(e) {
        "Can not be converted to date, check data"
      })
    }
    result_all = c(result_all, result)
  }
  df_snap$SelectedClass = class_selection
  df_snap$ConversionResult = result_all
  list(df=df, df_snap=df_snap)
}
