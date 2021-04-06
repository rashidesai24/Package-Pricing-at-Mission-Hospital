# Package Pricing at Mission Hospital

Built Predictive Model to estimate the price of treatment given the clinical factors at the time of admission.

<b> TABLE OF CONTENTS </b>

Objective <br>
Data Preparation <br>
Statistical Tests <br>
Model <br>

<b> OBJECTIVE </b>

 <li> Decide whether to use package pricing or traditional pricing <br> </li> 
 <li> Design a strategy as an accurate approach to predict the package price at time of admission <br>  </li> 
 <li> How to use package pricing as a competitive strategy <br> </li> 
 <li> Estimate the price of treatment given the clinical factors at the time of admission  </li> <br>


<b> Data Preparation </b>

<li>Age Categories - <10, 11 25, 26 50, 50 and above (as per domain expertise) </li>
<li>BP Ranges - Low, Normal, High, Critical (as per the medical charts)</li>
<li>BMI - Underweight, Normal, Overweight, Obese (as per the medical charts)</li>
<li>Hemoglobin "normal": Female 12 to 15.5, Men 13 to 17.5, any value outside these limits will be "abnormal"</li>
<li>Urea "normal": 7 to 20 mg/dl any value outside these limits will be "abrnormal"</li>
<li>Creatinine Categories: Age <3 & creatinine: 0.3-0.7 --> Normal, Age: 3-18 & creatinine: 0.5-1.0 --> Normal, Age >18 & Female & creatinine: 0.6 - 1.1 -->	Normal,
Age > 18 & Male & creatinine: 0.9 - 1.3 -->	Normal, Else: Abnormal</li> <br>

Removing Variables based on avalability of data

Considered ln(Total Cost) instead of Total Cost to Hospital(INR). The total cost value variable has a right skew. Taking the log would make the distribution of our transformed variable appear more symmetric.
From the below graphs we see that the data is normalized by taking the logarthmic value of the variable,

<b> Handling NULL Values </b>

BP Ranges Imputed 'Normal' BP range for null values which were Juvenile Patients
Urea Imputed 'Normal' Urea level for 11 null values. Assumption: Urea measurement is not critical for that patient.
 
 
<b> Statistical-Tests </b>

T-Test and Anova was performed on specific variable to understand their effect on target variable

T test was performed on variables with 2 categories. The following variables were removed as they proved insignificant,

other-heart
other-nervous
other-tetralogy
Diabetes
Hypertension
Hemoglobin
ANOVA test was done to test for variables with more than two levels and the following variables proved significant,

Age
BMI
BP Ranges
New categorical variables were derived flagging subjects with multiple health issues. The following are the conditions that were hypothesized based on domain expertise, and T-test was performed


<b> Model </b>

Logistic Regression Model to understand the relation between target variable and feature engineered variables,


