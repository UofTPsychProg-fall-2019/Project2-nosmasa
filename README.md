# Project2-nosmasa
Project 2: Build a Data Processing Pipeline 

For this project I attached a portion of my MA data (.xlxs file) and an R script that I am using to recode and preprocess the data.
The purpose of my study is to create multivariate statistical models of healthy aging, mild cognitiove impairment and Alzheimer's Disease. Correspondence analysis is a geometric approach for visualizing the rows and columns of a two-way contingency table as points in a low-dimensional space, such that the positions of the row and column points are consistent with their associations in the table.
In order to run a correspondence analysis, each variable output will be recoded to a number between 0 – 1 or, a residual will be computed, depending on the variable type. For example, a binary variable will be recoded into a 1 or a 0, whereas a continuous variable will be converted into z scores then an upper and lower bound for each variable is calculated (i.e.the upper bound will be (1+z-score)/2 and the lower bound will be (1-z-score)/2).

Once the data is recoded the correspondence analysis is run, this is represented in the attachments. 

1. The correspondence analysis graphs attached demonstrate: 
- Graphs 1 & 2 are the first 2 contribution plots that indicate how much variance each variable or observation contribute per component.

- Graph 3 indicates the correspondence analysis for all the re coded data; points far from the origin the more distinct they probably are vs points close to the origin are probably less distinct, points within the same quadrant probably have something in common
  For example: in quadrant 1 LMCI and low education seem to be similar to one another 

- Graph 4 shows all individuals within the study relationships to each other

2.The Scree plot.PNG is  
The eigenvalues of factors and is used to determine the number of factors to retain in an exploratory correspondence analysis. 
The eigenvalues here for dimension 1 = 0.1415, 16.93% varience explained and dimension 3 = 0.1207, 14.43% variance explained 

5.Visualize Diagnosis Age Sex Graph.PNG is a visualization of diosgnstic status by age filtered by sex. 

Legend for the variables in the excel sheet: 
ID	= Subject ID 
Diagnosis	 
Occ = Occupation (based on the National Occupation Categorization) 	
Sex	
Age	
Edu	+ Education (in years) 
MoCA = cognitive test 
MMSE= cogntive test 
LMImm	= logical immediate memory test 
LMDel	= logical delayed memory test
FAQ	- Functional Activities Questionnaire 
GDR	- Geriatric Depression Rating 
Syst= systolic blood pressure 
Dias	= diastolic blood pressure 
Pulse	= pulse (per minute)
Resp= respirations (per minute) 
BMI = body mass index 

