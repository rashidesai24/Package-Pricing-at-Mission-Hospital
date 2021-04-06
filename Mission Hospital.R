library(readr)
MissionHospital <- read_csv("/Users/rashidesai/Desktop/data.csv")
nrow(MissionHospital) # 248 rows of 23 (51 expanded) variables
data <- as.data.frame(MissionHospital)
attach(data)
str(data)

data$`MARITAL STATUS`<-as.factor(data$`MARITAL STATUS`)
data$`KEY COMPLAINTS -CODE`<-as.factor(data$`KEY COMPLAINTS -CODE`)
data$`PAST MEDICAL HISTORY CODE`<-as.factor(data$`PAST MEDICAL HISTORY CODE`)
data$`MODE OF ARRIVAL`<-as.factor(data$`MODE OF ARRIVAL`)
data$`STATE AT THE TIME OF ARRIVAL`<-as.factor(data$`STATE AT THE TIME OF ARRIVAL`)
data$`TYPE OF ADMSN`<-as.factor(data$`TYPE OF ADMSN`)
data$`IMPLANT USED (Y/N)`<-as.factor(data$`IMPLANT USED (Y/N)`)
data$ACHD<-as.factor(data$ACHD)
data$`CAD-DVD`<-as.factor(data$`CAD-DVD`)
data$`CAD-SVD`<-as.factor(data$`CAD-SVD`)
data$`CAD-TVD`<-as.factor(data$`CAD-TVD`)
data$`CAD-VSD`<-as.factor(data$`CAD-VSD`)
data$`OS-ASD`<-as.factor(data$`OS-ASD`)
data$`other- heart`<-as.factor(data$`other- heart`)
data$`other- respiratory`<-as.factor(data$`other- respiratory`)
data$`other-general`<-as.factor(data$`other-general`)
data$`other-nervous`<-as.factor(data$`other-nervous`)
data$`other-tertalogy`<-as.factor(data$`other-tertalogy`)
data$`PM-VSD`<-as.factor(data$`PM-VSD`)
data$RHD<-as.factor(data$RHD)
data$`BP-LOW`<-as.numeric(data$`BP-LOW`)
data$Diabetes1<-as.factor(data$Diabetes1)
data$Diabetes2<-as.factor(data$Diabetes2)
data$hypertension1<-as.factor(data$hypertension1)
data$hypertension2<-as.factor(data$hypertension2)
data$hypertension3<-as.factor(data$hypertension3)
data$other<-as.factor(data$other)
data$GENDER<-as.factor(data$GENDER)
data$AGE<-as.numeric(data$AGE)

str(data)

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
# DATA PREPARATION
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------

#Age Group Bins
data$AGE_GROUP[data$AGE<=10]="Child"
data$AGE_GROUP[data$AGE>10 & data$AGE<=25]="Youngadult"
data$AGE_GROUP[data$AGE>26 & data$AGE<=50]="Adult"
data$AGE_GROUP[data$AGE>=50]="Old"
data$AGE_GROUP<-as.factor(data$AGE_GROUP)
plot(data$AGE_GROUP, col = "gold", xlab= "Age", ylab = "Frequency", main = "Distribution of Age")

#Haemoglobin Bins
data$HB_LEVEL[data$HB<11]<-"Low"
data$HB_LEVEL[data$HB>=11]<-"Normal"
data$HB_LEVEL<-as.factor(data$HB_LEVEL)
plot(data$HB_LEVEL, col = "darkgreen", xlab= "Haemoglobin Level", ylab = "Frequency", main = "Distribution of Haemoglobin")

#Urea Bins
data$UREA[data$UREA<20]<-"Normal"
data$UREA[data$UREA>=21]<-"Abormal"
data$UREA<-as.factor(data$UREA)
plot(data$UREA, col = "darkgreen", xlab= "UREA Level", ylab = "Frequency", main = "Distribution of UREA")


#BMI
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)<=18.5]="Underweight"
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)>18.5 & data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)<25]="Normal"
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)>=25 & data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)<30]="Overweight"
data$BMI[data$`BODY WEIGHT`/'^'((data$`BODY HEIGHT`/100),2)>=30]="Obese"
data$BMI<-as.factor(data$BMI)
plot(data$BMI, col = "darkred", xlab= "BMI Levels", ylab = "Frequency", main = "Distribution of BMI")

#Blood pressure categories
data$BP_Cat[data$`BP -HIGH`<120 & data$`BP-LOW`<80]<- "Normal"
data$BP_Cat[(data$`BP -HIGH`>119 & data$`BP-LOW`<130) & data$`BP-LOW`<80]<- "Elevated"
data$BP_Cat[(data$`BP -HIGH`>129 & data$`BP -HIGH`<140) | (data$`BP-LOW`>79 & data$`BP-LOW`<90)]<- "Hypertension Stage 1"
data$BP_Cat[data$`BP -HIGH`>= 140 | data$`BP-LOW`>=90]<- "Hypertension Stage 2"
data$BP_Cat[data$`BP -HIGH`> 180 | data$`BP-LOW`>120]<- "Hypertensive Crisis"
data$BP_Cat<-as.factor(data$BP_Cat)
plot(data$BP_Cat, col = "steelblue", xlab= "BP Levels", ylab = "Frequency", main = "Distribution of BP")

#CREATININE_LEVEL

data$CREATININE_LEVEL[data$AGE<=3 & data$CREATININE>=0.3 &data$CREATININE<=0.7 ]="Normal"
data$CREATININE_LEVEL[data$AGE>3 & data$AGE<=18 & data$CREATININE>=0.5 &data$CREATININE<=1.0 ]="Normal"
data$CREATININE_LEVEL[data$AGE>18 & data$FEMALE==1 & data$CREATININE>=0.6 &data$CREATININE<=1.1 ]="Normal"
data$CREATININE_LEVEL[data$AGE>18 & data$FEMALE==0 & data$CREATININE>=0.9 &data$CREATININE<=1.3 ]="Normal"
data$CREATININE_LEVEL[is.na(data$CREATININE_LEVEL)]<-"Abnormal"
data$CREATININE_LEVEL<-as.factor(data$CREATININE_LEVEL)
plot(data$CREATININE_LEVEL, col = "purple4", xlab= "Creatinine Levels", ylab = "Frequency", main = "Distribution of Creatinine Levels")
sum(is.na(data$CREATININE_LEVEL))

data <- subset(data, select = -c(`BP -HIGH`, `BP-LOW`, CREATININE))
glimpse(data)

library(dplyr)
data<- as.data.frame(mutate(data, UREA_cat = ifelse(UREA %in% 7:20,"Normal","Abnormal" )))
data$UREA_cat<-as.factor(data$UREA_cat)
sum(is.na(data$UREA_cat))


library(visdat)
vis_dat(data)


library(car) # for detailed correlation plot 
library(corrplot) # for correlation plot
library(Hmisc) # for correlation test of multiple variables 
cnum <- data[,c( "TOTAL LENGTH OF STAY", "LENGTH OF STAY - ICU", "LENGTH OF STAY- WARD")]
cormat <- cor(cnum) # Select only numeric variables
corrplot(cormat, method="circle", addCoef.col="black") # With correlation

cnum <- data[,c( "BODY WEIGHT", "BODY HEIGHT")]
cormat <- cor(cnum) # Select only numeric variables
corrplot(cormat, method="circle", addCoef.col="black") # With correlation

data$Diabetes1 <- as.numeric(data$Diabetes1)
data$Diabetes2 <- as.numeric(data$Diabetes2)
data$hypertension1 <- as.numeric(data$hypertension1)
data$hypertension2 <- as.numeric(data$hypertension2)
data$hypertension3 <- as.numeric(data$hypertension3)
data$`CAD-DVD` <- as.numeric(data$`CAD-DVD`)


cnum <- data[,c("BODY WEIGHT", "Diabetes1", "Diabetes2", "hypertension1", "hypertension2", "hypertension3", "CAD-DVD")]
cormat <- cor(cnum) # Select only numeric variables
corrplot(cormat, method="circle", addCoef.col="black") # With correlation

sum(is.na(data))
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
# UNIVARIATE ANALYSIS
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------

# TARGET VARIABLE

options(scipen = 999)
hist(data$`TOTAL COST TO HOSPITAL`, col = "lightblue", xlab = "Total Cost to Hospital (in INR)", main = "Distribution of Total Cost to Hospital")
summary(data$`TOTAL COST TO HOSPITAL`)
boxplot(data$`TOTAL COST TO HOSPITAL`, col = "pink", xlab = "Total Cost to Hospital (in INR)", main = "Distribution of Total Cost to Hospital")

hist(data$`Ln(Total Cost)`, col = "lightblue", xlab = "Total Cost to Hospital (in INR)", main = "Distribution of Total Cost to Hospital")
boxplot(data$`Ln(Total Cost)`, col = "pink", xlab = "Total Cost to Hospital (in INR)", main = "Distribution of Total Cost to Hospital")


data$AGE_GROUP
sum(is.na(data$BP_cat))

anova_oneway <- aov(data$`TOTAL LENGTH OF STAY`~data$AGE_GROUP, data = data)
summary(anova_oneway)
TukeyHSD(anova_oneway)



#----------------------------------------------------------------------------------------------------------------------------------------
# Question 1: Bosy Weight and Total Cost
#----------------------------------------------------------------------------------------------------------------------------------------

# Modelling

hist(data$`BODY WEIGHT`)

linear <- lm(data$`Ln(Total Cost)`~data$`BODY WEIGHT`)
summary.fit<- summary(linear)
summary.fit

#----------------------------------------------------------------------------------------------------------------------------------------
# MODEL 1
#----------------------------------------------------------------------------------------------------------------------------------------

# Split the data into training and test set
set.seed(123)
training.samples <- data$`TOTAL COST TO HOSPITAL` %>%createDataPartition(p = 0.8, list = FALSE)
train.data  <- data[training.samples, ]
test.data <- data[-training.samples, ]

# Build the model
model <- lm(`Ln(Total Cost)` ~ MALE + UNMARRIED + BP_Cat + Diabetes1+`Diabetes2`+`hypertension1`+`hypertension2`+`hypertension3`+
              `other` +`ACHD`+`CAD-DVD`+`CAD-SVD`+`CAD-TVD`+`OS-ASD`+ `CAD-VSD`+
              `PM-VSD`+ RHD  + `other- respiratory`+ `other-general`+ ACHD + `CAD-DVD` + `CAD-SVD`, data = train.data)
# Summarize the model
summary(model)
# Make predictions
predictions <- model %>% predict(test.data)
# Model performance
# (a) Prediction error, RMSE
RMSE(predictions, test.data$`Ln(Total Cost)`)
# (b) R-square
R2(predictions, test.data$`Ln(Total Cost)`)

#----------------------------------------------------------------------------------------------------------------------------------------
# MODEL 2
#----------------------------------------------------------------------------------------------------------------------------------------


# Split the data into training and test set
set.seed(123)
training.samples <- data$`TOTAL COST TO HOSPITAL` %>%createDataPartition(p = 0.8, list = FALSE)
train.data  <- data[training.samples, ]
test.data <- data[-training.samples, ]

# Build the model
model <-lm(`Ln(Total Cost)` ~ BMI + AGE_GROUP  + AMBULANCE + `COST OF IMPLANT` + `LENGTH OF STAY - ICU` + 
             `LENGTH OF STAY- WARD`+ `IMPLANT USED (Y/N)` + `MODE OF ARRIVAL` + `STATE AT THE TIME OF ARRIVAL`, data = train.data)
# Summarize the model
summary(model)
# Make predictions
predictions <- model %>% predict(test.data)
# Model performance
# (a) Prediction error, RMSE
RMSE(predictions, test.data$`Ln(Total Cost)`)
# (b) R-square
R2(predictions, test.data$`Ln(Total Cost)`)

#----------------------------------------------------------------------------------------------------------------------------------------
# ENSEMBLE MODEL
#----------------------------------------------------------------------------------------------------------------------------------------

# Split the data into training and test set
set.seed(123)
training.samples <- data$`TOTAL COST TO HOSPITAL` %>%createDataPartition(p = 0.8, list = FALSE)
train.data  <- data[training.samples, ]
test.data <- data[-training.samples, ]

# Build the model
model <- lm(`Ln(Total Cost)` ~ UNMARRIED + `ACHD`+`CAD-DVD`+`CAD-TVD`+ `other-general`+`COST OF IMPLANT` + 
              `LENGTH OF STAY - ICU` + `LENGTH OF STAY- WARD` + AGE_GROUP + `MODE OF ARRIVAL` + RHD, data = train.data)
# Summarize the model
summary(model)
# Make predictions
predictions <- model %>% predict(test.data)
# Model performance
# (a) Prediction error, RMSE
RMSE(predictions, test.data$`Ln(Total Cost)`)
# (b) R-square
R2(predictions, test.data$`Ln(Total Cost)`)

coefficients(model)
varImp(model)

confint(model)

