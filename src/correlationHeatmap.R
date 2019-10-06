correlationHeatmap = function(mtlCorr){
  suppressMessages(library(ggplot2))
  suppressMessages(library(plotly))
  suppressMessages(library(reshape))
  
  mtlr = melt(mtlCorr)
  gx = ggplot(mtlr, aes(X1, X2, fill = value)) + geom_tile() + 
    scale_fill_gradient(low = "cyan",  high = "red", limits = c(-1,1))
  gx = gx + theme(axis.text.x = element_text(angle = 90))
  ggplotly(gx)
}
