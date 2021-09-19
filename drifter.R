rm(list=ls())

#***************************************************************************************************************************
## The concept drift analysis using drifter tools
#***************************************************************************************************************************

#Link to the tool: 
#Documentation: https://cran.r-project.org/web/packages/drifter/drifter.pdf
#Paper reference: 

#===========================================================================================================================
#Short Description:
# Concept drift refers to the change in the data distribution or in the relationships between variables over time.
# 'drifter' calculates distances between variable distributions or variable relations and identifies both types of drift.
#===========================================================================================================================

#Path:
setwd('C:/Users/Jana Schwarzerova/Desktop/PhD/KiNG/Iwbbio2021/R_Tools')

#Installation Notes
install.packages("drifter")
library(drifter)

#Loading dataset:
BM <- read.csv("C:/Users/Jana Schwarzerova/Desktop/PhD/KiNG/Iwbbio2021/Dataset/BM.csv",header=T,sep = ";")
GM <- read.csv("C:/Users/Jana Schwarzerova/Desktop/PhD/KiNG/Iwbbio2021/Dataset/GM.csv",header=T,sep = ";")

#UM <- read.csv("C:/Users/Jana Schwarzerova/Desktop/PhD/KiNG/Iwbbio2021/Dataset/UM.csv",header=T,sep = ";")

ppBM <- BM;
ppGM <- GM;
pom <- 1;
#Pre-processing: 
for (i in 1:length(BM$annotation)){
  for (j in 1:length(GM$Top.annotation.name)){
    if (BM$annotation[i] == GM$Top.annotation.name[j]){
      ppBM[pom,] <- BM[i,];
      ppGM[pom,] <- GM[j,];
      pom <- pom + 1;
    } 
  }
}
ppBM <- ppBM[1:pom-1,3:length(ppBM)];
ppGM <- ppGM[1:pom-1,c(8:length(ppGM))];

#Calculate Covariate Drift for two data frames:
LacDrift <- calculate_covariate_drift(ppBM[1,], ppGM[1,]); #Lac / Lactate
PyrDrift <- calculate_covariate_drift(ppBM[2,], ppGM[2,]); #Pyr / Pyruvate

match <- 0;
for (i in 1:length(LacDrift$variables)){
  for (j in 1:length(PyrDrift$variables)){
    if (LacDrift$variables[i] == PyrDrift$variables[j]){
      match <- match + 1;
    } 
  }
}


