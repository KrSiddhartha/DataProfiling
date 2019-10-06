df = dat
df_snap = dat_snap
column = "Age"
# rm(df, df_snap, column, targetColumn)

suppressMessages(require(dplyr))
suppressMessages(require(reshape2))
suppressMessages(require(splitstackshape))
suppressMessages(require(PerformanceAnalytics))

df_listCreated = dataTypeFrames(df)

mixedVarCor(df_listCreated$df_cor)
summaryIntNum(df_listCreated$df_num)
summaryIntNum(df_listCreated$df_int)
df_listCreated$df_numToFact = numToFact(dfCalc = df_listCreated$df_cor, HumanAge = "Age")
cor_tab = mixedVarCor(cbind(df_listCreated$df_cor,df_listCreated$df_numToFact))
correlationHeatmap(cor_tab)
chart.Correlation(cbind(df_listCreated$df_int,df_listCreated$df_num), histogram=TRUE, pch=19)

