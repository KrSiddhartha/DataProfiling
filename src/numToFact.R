numToFact = function(dfCalc, HumanAge=NULL, probsValsSeq=c(0.25,0.20,0.1,0.05)){
  # dfCalc=df_listCreated$df_cor
  # HumanAge=NULL
  # HumanAge="Age"
  # variables="Parch"
  # probsVals=0.25
  # probsValsSeq = c(0.25,0.20,0.1,0.05)
  # rm(dfCalc,HumanAge,percentileCategory,percentileDistribution,colName,variables,probsValsSeq,probsVals,numIntVars)
  
  dfCalc = dfCalc %>% select_if(is.numeric)
  numIntVars=names(dfCalc)
  
  for(variables in names(dfCalc)){
    
    if(is.null(HumanAge)==F & variables==HumanAge){
      percentileCategory = cut(dfCalc[[variables]], breaks = c(0,9,19,24,59,Inf),
                               labels = c("Child","Teen","Young","Adult","Old")) %>% as.numeric()
      colName = paste0(variables,"_WHO1")
      dfCalc[[colName]] = percentileCategory
      percentileCategory = cut(dfCalc[[variables]], breaks = c(0,1,4,14,24,34,44,54,64,74,Inf)) %>% as.numeric()
      colName = paste0(variables,"_WHO2")
      dfCalc[[colName]] = percentileCategory
      
    }
    
    for(probsVals in probsValsSeq){
      percentileDistribution = quantile(dfCalc[[variables]], na.rm = T, probs = seq(0,1,probsVals)) %>% 
        as.numeric()
      percentileCategory = cut(dfCalc[[variables]], breaks = unique(percentileDistribution))
      if(length(levels(percentileCategory))<2){
        next()
      }
      colName = paste0(variables,"_",probsVals)
      dfCalc[[colName]] = percentileCategory
    }
  }
  
  dfCalc = dfCalc %>% select(-numIntVars)
  return(dfCalc)
}