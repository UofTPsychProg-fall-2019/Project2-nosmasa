#Project 2 - Build a Data Processing Pipeline  
#Author: Alex Samson 
#This is the processing pipeline for my Master's data. 
#I am looking at similarities and differences in 
#healthy aging,mild cognitive impairment, and Alzheimer's Disease patients 
#through the use of correspondance analysis and statistical modeling. 


library(readxl)
library(tidyverse)
library(ggplot2)
library(ExPosition)
library(ggExtra)

#Read in data from excel
df = read_excel("Project2.xlsx")

#GENERAL STATS ------
#visualizations and general trends of the data can be analyzed 

#recode Diagnoses 
df$Diagnosis <- recode(df$Diagnosis, "1" = 'HC', "2" = 'EMCI', "3" = 'LMCI', "4" = 'AD')
#HC = healthy control, EMCI = early mild cognitive impairment
#LMCI = late mild cognitive impairment, AD = Alzheimer's Disease

#Bar graph showing how many participants in each diagnostic group 
ggplot(df, aes(x=Diagnosis)) +
  geom_bar(aes(fill = Diagnosis))
#recode Sex to M = male, F = Female 
df$Sex <- recode(df$Sex, "1" = 'M', "2" = 'F')

#Bar graph showing how many participants in each diagnostic group 
ggplot(df, aes(x=Sex)) +
  geom_bar(aes(fill = Sex))

#boxplot of diagnostic group by age between males and females
ggplot(df, aes(x = Diagnosis, y = Age,
               fill=Sex)) +
  geom_boxplot()

#boxplot of Diagnostic status by years of education between males and females
ggplot(df, aes(x = Diagnosis, y = Edu,
               fill=Sex)) +
  geom_boxplot()

#Visualization of Cognitive Scores by Diagnosis  
ggplot(df, aes(x=Diagnosis, y=MoCA, fill = Diagnosis)) +
  geom_point() + geom_boxplot()

ggplot(df, aes(x=Diagnosis, y=MMSE, fill = Diagnosis)) +
  geom_point() + geom_boxplot()

#Visualization of Depression Score by Diagnosis 
ggplot(df, aes(x=Diagnosis, y=GDR, fill = Diagnosis)) +
  geom_point() + geom_boxplot()

#Visualization of BMI by Diagnosis 
ggplot(df, aes(x=Diagnosis, y=BMI, fill = Diagnosis)) +
  geom_point() + geom_boxplot()


#Recoding (for correspondance analysis)------
#Create new dataframe to begin recoding process
df_CA <- data.frame(Subject=df$`ID`) 

#Catgorigal Data Recoded----

#Diagnoses 
df_CA$HC = as.numeric(df$Diagnosis == 1) #healthy controls 
df_CA$EMCI = as.numeric(df$Diagnosis == 2) #early mild cognitive impairment 
df_CA$LMCI = as.numeric(df$Diagnosis == 3) #late mild cognitive impairment
df_CA$AD = as.numeric(df$Diagnosis == 4) #Alzheimer's patients 


#Contunous Variables Recoded ----
#for continous variables an uppper and lower bound for each variable needs to be calculated
#a z score needs to be calculated first for continuous variables 
#Age 
z = scale(df$Age) #convert to Z scores for continuous variables 
df_CA$AgeLow = (1-z)/2#upper bound fuzzy coding 
df_CA$AgeHigh= (1+z)/2#lower bound fuzzy coding

#Education (in years) 
z = scale(df$Edu) #convert to Z scores for continuous variables 
df_CA$EduLow = (1-z)/2#upper bound fuzzy coding 
df_CA$EduHigh= (1+z)/2#lower bound fuzzy coding


#Systolic BLood Pressure (mmHg)
z3 = scale(df$Syst)#convert to Z scores for continuous variables 
df_CA$BPSysLow = (1-z3)/2#upper bound fuzzy coding 
df_CA$BPSysHigh= (1+z3)/2#lower bound fuzzy coding

#Diastolic Blood Pressure (mmHg)
z4 = scale(df$Dias)#convert to Z scores for continuous variables 
df_CA$BPDiLow = (1-z4)/2#upper bound fuzzy coding 
df_CA$BPDiHigh= (1+z4)/2#lower bound fuzzy coding

#Pulse rate (per minute) 
z5 = scale(df$Pulse)#convert to Z scores for continuous variables 
df_CA$PulseLow = (1-z5)/2#upper bound fuzzy coding 
df_CA$PulseHigh= (1+z5)/2#lower bound fuzzy coding

#Respirations (per minute)
z6 = scale(df$Resp)#convert to Z scores for continuous variables 
df_CA$RespLow = (1-z6)/2#upper bound fuzzy coding 
df_CA$RespHigh= (1+z6)/2#lower bound fuzzy coding

#BMI (kg/m^2)
z7 = scale(df$BMI)#convert to Z scores for continuous variables 
df_CA$BMIpLow = (1-z7)/2#upper bound fuzzy coding 
df_CA$BMIHigh= (1+z7)/2#lower bound fuzzy coding

#Ordered Data Recoded  ----
#like continous variables an uppper and lower bound for each variable needs to be calculated

#MoCa
df_CA$MoCAHigh = df$MoCA/max(df$MoCA, na.rm = TRUE)#upper bound fuzzy coding 
df_CA$MoCALow = 1-df_CA$MoCAHigh#lower bound fuzzy coding

#MMSE
df_CA$MMSEHigh = df$MMSE/max(df$MMSE, na.rm = TRUE)#upper bound fuzzy coding 
df_CA$MMSELow = 1-df_CA$MMSEHigh#lower bound fuzzy coding

#Logical Memory Test Immediate
df_CA$LMIHigh = df$LMImm/max(df$LMImm,na.rm = TRUE)#upper bound fuzzy coding 
df_CA$LMILow = 1-df_CA$LMIHigh #lower bound fuzzy coding

#Logical Memory Test Delayed 
df_CA$LMDHigh = df$LMDel/max(df$LMDel, na.rm = TRUE)#upper bound fuzzy coding 
df_CA$LMDLow = 1-df_CA$LMDHigh#lower bound fuzzy coding

#FAQ - Functional Activies Questionnaire 
df_CA$FAQHigh = df$FAQ/max(df$FAQ, na.rm = TRUE)#upper bound fuzzy coding 
df_CA$FAQLow = 1-df_CA$FAQHigh#lower bound fuzzy coding

#Geriatric Depression Rating Scale 
df_CA$GDRHigh = df$GDR/max(df$GDR, na.rm = TRUE)#upper bound fuzzy coding 
df_CA$GDRLow = 1-df_CA$GDRHigh#lower bound fuzzy coding

#Now that all the variables are recoded the correspondance analysis can be run 

#RESULTS (Correspondance Analysis) -------------- 

#use the exposition library ep Correspondance analysis function 
#na.omit to omit NAs 
#[1:90,2:31] because we don't want to include the subject ID numbers to the analysis 
results <- epCA(na.omit(df_CA[1:90,2:31]), graphs = T)

#eigenvalues, variance percentages, cumulative variance percentages given 
eig.val <- get_eigenvalue(results)

#To visualize the precentages of inertia explained by each MCA dimension 
fviz_eig(results, addlables = TRUE, ylim = c(0,25))
#0 - 35 represents the min and max y axes numbers 

