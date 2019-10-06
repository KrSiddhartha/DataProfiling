# Setting Options ---------------------------------------------------------
options(scipen = 999)

# Loading Libraries -------------------------------------------------------
# suppressMessages(library(data.table))
# suppressMessages(library(dplyr))


# Sourcing Functions ------------------------------------------------------
source(file = "src/numToFact.R")
source(file = "src/CombFiles.R")
source(file = "src/classChange.R")
source(file = "src/dataSnapshot.R")
source(file = "src/mixedVarCor.R")
source(file = "src/summaryIntNum.R")
source(file = "src/dataTypeframes.R")
source(file = "src/correlationHeatmap.R")

# Importing Data ----------------------------------------------------------
dat = combineFiles("data/")
dat_snap = dataSnapshot(dat)
tmp = classChange(dat, dat_snap)
dat = tmp$df
dat_snap = tmp$df_snap
rm(tmp)

dat$DATE_CLASS = Sys.time()

# rm(list = setdiff(ls(), c("dat", "dat_snap")))
