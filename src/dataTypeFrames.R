dataTypeFrames = function(dfDataTypes, targetColumn=NULL){
  suppressMessages(require(dplyr))
  # rm(df_target,
  #    df_num,
  #    df_int,
  #    df_char,
  #    df_fact,
  #    df_date,
  #    df_cor,
  #    date_cols,
  #    df_list)
  
  df_target = select(dfDataTypes, targetColumn)
  df_num = select_if(dfDataTypes, Negate(is.integer))
  df_num = select_if(df_num, is.numeric)
  df_int = select_if(dfDataTypes, is.integer)
  df_char = select_if(dfDataTypes, is.character)
  df_fact = select_if(dfDataTypes, is.factor)
  date_cols = names(dfDataTypes)[!(names(dfDataTypes) %in% c(names(df_char), names(df_num), names(df_int), names(df_fact)))]
  df_date = data.frame(dfDataTypes[[date_cols]])
  names(df_date) = date_cols
  df_cor = cbind(df_fact, df_int, df_num)
  df_cor$FILE_NAME = NULL
  
  df_list = list(
    df_num = df_num,
    df_int = df_int,
    df_char = df_char,
    df_fact = df_fact,
    df_date = df_date,
    df_cor = df_cor
  )
  if(is.null(targetColumn)==F) df_list$df_target = df_target
  
  return(df_list)
}
