summaryIntNum = function(df){
  df_summary = summary(df) %>% as.data.frame()
  df_summary = cSplit(df_summary, splitCols = "Freq", sep = ":")
  df_summary = df_summary %>% select(Freq_1,Var2,Freq_2)
  names(df_summary) = c("Measure", "Column", "Value")
  df_summary = dcast(data = df_summary, formula = Measure~Column, value.var = "Value")
  df_summary = df_summary %>% filter(is.na(Measure)==F , Measure!="NA's")
  df_summary$Measure = as.character(df_summary$Measure)
  df_summary = df_summary %>%
    arrange(match(Measure, c("Min.", "1st Qu.","Mean","Median","3rd Qu.","Max.")), desc(Measure), desc(Measure))
  
  return(df_summary)
}