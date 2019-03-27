*********************
*** Final Project *** 
*********************

* Author: Yi Zuo
* Date last modified: 03/14/2019
* cd Google\ Drive\ File\ Stream/My\ Drive/Vanderbilt/2nd\ Semester\ 2018-2019/Bios6312_Regression/Bios6312Project/

********************************************************************************
* STEP ONE: DATA PREPARATION
********************************************************************************
cd "/Volumes/GoogleDrive/My Drive/Vanderbilt/2nd Semester 2018-2019/Bios6312_Regression/Bios6312Project"

* import data
clear
import delimited "Data/body.dat.txt", delimiter(" ",collapse)

* label variables
label var v1 "Biacromial skeletal"
label var v2 "Biiliac skeletal"
label var v3 "Bitrochanteric skeletal"
label var v4 "Chest depth skeletal"
label var v5 "Chest skeletal"
label var v6 "Elbow skeletal"
label var v7 "Wrist skeletal"
label var v8 "Knee skeletal"
label var v9 "Ankle skeletal"
label var v10 "Shoulder girth"
label var v11 "Chest girth"
label var v12 "Waist girth"
label var v13 "Navel girth"
label var v14 "Hip girth"
label var v15 "Thigh girth"
label var v16 "Bicep girth"
label var v17 "Forearm girth"
label var v18 "Knee girth"
label var v19 "Calf girth"
label var v20 "Ankle girth"
label var v21 "Wrist girth"
label var v22 "Age"
label var v23 "Weight"
label var v24 "Height"
label var v25 "Gender"

* rename variables
rename v1 BiacromialS
rename v2 BiiliacS
rename v3 BitrochantericS
rename v4 ChestDepthS
rename v5 ChestS
rename v6 ElbowS
rename v7 WristS
rename v8 KneeS
rename v9 AnkleS
rename v10 ShoulderG
rename v11 ChestG
rename v12 WaistG
rename v13 NavelG
rename v14 HipG
rename v15 ThighG
rename v16 BicepG
rename v17 ForearmG
rename v18 KneeG
rename v19 CalfG
rename v20 AnkleG
rename v21 WristG
rename v22 Age
rename v23 Weight
rename v24 Height
rename v25 Gender

* label gender
label define genderl 1 "male" 0 "female"
label value Gender genderl

* generate BMI
gen BMI = Weight/(Height/100)^2

label var BMI "BMI, kg/m^2"

save"Data/body.dta",replace






use"Data/body.dta",clear

********************************************************************************
* STEP TWO: DESCRIPTIVE STATISTICS
********************************************************************************

*************************
* Skeletal measurements *
*************************

* Biacromial diameter
summ BiacromialS, d // no missing
hist BiacromialS // looks approximately normal
kdensity BiacromialS

ttest BiacromialS, by(Gender) // p<0.00001

* Biiliac skeletal
summ BiiliacS, d // no missing
hist BiiliacS // looks approximately normal
kdensity BiiliacS

ttest BiiliacS, by(Gender) // p=0.0092

* Bitrochanteric skeletal
summ BitrochantericS, d // no missing
hist BitrochantericS // looks approximately normal
kdensity BitrochantericS

ttest BitrochantericS, by(Gender) // p<0.00001

* Chest depth skeletal
summ ChestDepthS, d // no missing
hist ChestDepthS // looks not normal
kdensity ChestDepthS

ttest ChestDepthS, by(Gender) // p<0.00001

* Chest skeletal
summ ChestS, d // no missing
hist ChestS // looks not normal
kdensity ChestS

ttest ChestS, by(Gender) // p<0.00001

* Elbow skeletal
summ ElbowS, d // no missing
hist ElbowS // looks approximately normal
kdensity ElbowS

ttest ElbowS, by(Gender) // p<0.00001

* Wrist skeletal
summ WristS, d // no missing
hist WristS // looks approximately normal
kdensity WristS

ttest WristS, by(Gender) // p<0.00001

* Knee skeletal
summ KneeS, d // no missing
hist KneeS // looks not normal
kdensity KneeS

ttest KneeS, by(Gender) // p<0.00001

* Ankle skeletal
summ AnkleS, d // no missing
hist AnkleS // looks approximately normal
kdensity AnkleS

ttest AnkleS, by(Gender) // p<0.00001

// looks like all skeletal measurements are highly correlated with gender

**********************
* Girth measurements *
**********************

* Shoulder girth
summ ShoulderG, d // no missing
hist ShoulderG // looks not normal
kdensity ShoulderG

corr ShoulderG Weight // rho=0.88
corr ShoulderG BMI // rho=0.70

* Chest girth
summ ChestG, d // no missing
hist ChestG // looks approximately normal
kdensity ChestG

corr ChestG Weight // rho=0.90
corr ChestG BMI // rho=0.76

* Waist girth
summ WaistG, d // no missing
hist WaistG // looks not normal
kdensity WaistG

corr WaistG Weight // rho=0.90
corr WaistG BMI // rho=0.82

* Navel girth
summ NavelG, d // no missing
hist NavelG // looks approximately normal
kdensity NavelG

corr NavelG Weight // rho=0.71
corr NavelG BMI // rho=0.76

* Hip girth
summ HipG, d // no missing
hist HipG // looks approximately normal
kdensity HipG

corr HipG Weight // rho=0.76
corr HipG BMI // rho=0.81

* Thigh girth
summ ThighG, d // no missing
hist ThighG // looks not normal
kdensity ThighG

corr ThighG Weight // rho=0.56
corr ThighG BMI // rho=0.70

* Bicep girth
summ BicepG, d // no missing
hist BicepG // looks not normal
kdensity BicepG

corr BicepG Weight // rho=0.87
corr BicepG BMI // rho=0.74

* Forearm girth
summ ForearmG, d // no missing
hist ForearmG // looks not normal
kdensity ForearmG

corr ForearmG Weight // rho=0.87
corr ForearmG BMI // rho=0.70

* Knee girth
summ KneeG, d // no missing
hist KneeG // looks not normal
kdensity KneeG

corr KneeG Weight // rho=0.80
corr KneeG BMI // rho=0.70

* Calf girth
summ CalfG, d // no missing
hist CalfG // looks approximately normal
kdensity CalfG

corr CalfG Weight // rho=0.77
corr CalfG BMI // rho=0.72

* Ankle girth
summ AnkleG, d // no missing
hist AnkleG // looks approximately normal
kdensity AnkleG

corr AnkleG Weight // rho=0.76
corr AnkleG BMI // rho=0.61

* Wrist girth
summ WristG, d // no missing
hist WristG // looks not normal
kdensity WristG

corr WristG Weight // rho=0.82
corr WristG BMI // rho=0.59

// not all covariates are highly correlated with the outcomes
// some covariates may be only highly correlated with one outcome

**********************
* Other measurements *
**********************

* Age
summ Age, d // no missing
hist Age // looks not normal
kdensity Age

ttest Age, by(Gender) // p=0.0006
corr Age Weight // rho=0.21
corr Age BMI // rho=0.24

* Height
summ Height, d // no missing
hist Height // looks approximately normal
kdensity Height

corr Height Weight // rho=0.72
corr Height BMI // rho=0.20

********************************************************************************
* STEP THREE: MODEL FOR AIM 1A (PREDICT WEIGHT WITH SKELETAL AND THREE GIRTH)
********************************************************************************

*******************************
* Aim 1-a-1 Constant measures *
*******************************

clear
use"Data/body.dta"

* Dependent variable: weight
gladder Weight
// log transformation might be good?

gen lWeight = log(Weight)

******************************************
* Model selection using best with height *
******************************************

vselect lWeight BiacromialS-AnkleS Gender Age Height, best
// ChestDepthS ChestS KneeS BitrochantericS Height WristS Age BiiliacS BiacromialS

vselect lWeight BiacromialS BiiliacS BitrochantericS ChestDepthS ChestS ElbowS   ///
AnkleG KneeG WristG Gender Age Height, best
// ChestDepthS KneeG ChestS Height BitrochantericS WristG BiiliacS Age ElbowS BiacromialS AnkleG Gender

* Comparison of two models
reg lWeight ChestDepthS ChestS KneeS BitrochantericS Height WristS Age BiiliacS BiacromialS
estat ic
// AIC: -1345.172
rvfplot

reg lWeight ChestDepthS KneeG ChestS Height BitrochantericS WristG BiiliacS Age ElbowS BiacromialS AnkleG Gender
estat ic
// AIC: -1481.041
rvfplot


* Backward selection using AIC 

vselect lWeight BiacromialS-AnkleS Gender Age Height, backward aic
// -1345.172


vselect lWeight BiacromialS BiiliacS BitrochantericS ChestDepthS ChestS ElbowS   ///
AnkleG KneeG WristG Gender Height Age, backward aic
// -1481.041

// same model as `best`


************************
* Aim 1-a-2 Square sum *
************************																   

** all girth
* First method: sum first, then square, finally multiply
egen sum_G = rowtotal(*G)
gen sq_sum_G = sum_G^2
gen sq_sum_G_height = sq_sum_G * Height

reg lWeight sq_sum_G_height Gender Age
estat ic

reg lWeight sq_sum_G_height Age
estat ic
// AIC (-1853.184) is smaller so this is a better model, so no gender.

* Second method: multiply first, then sum, finally square
for var *G: gen X_H = X * Height
egen sum_G2 = rowtotal(*_H)
gen sq_sum_G2 = sum_G2^2

reg lWeight sq_sum_G2 Gender Age
estat ic // AIC=-1545.835 much greater than first method

** three constant girth
* First method: sum first, then square, finally multiply
egen sum_3 = rowtotal(WristG KneeG AnkleG)
gen sq_sum_3 = sum_3^2
gen sq_sum_3_height = sq_sum_3 * Height

reg lWeight sq_sum_3_height Gender Age
estat ic

// AIC= -1105.635 is big

* Second method: multiply first, then sum, finally square
for var WristG KneeG AnkleG: gen X_h = X * Height
egen sum_G2_3 = rowtotal(*_h)
gen sq_sum_G2_3 = sum_G2_3^2

reg lWeight sq_sum_G2_3 Gender Age
estat ic // AIC=-1041.318 greater than first method

***********************************************
* STEP FOUR: MODEL DIAGNOSTICS AND VALIDATION *
*********************************************** 

****************
* Model 1a-1-2 *
****************

reg lWeight ChestDepthS KneeG ChestS Height BitrochantericS WristG BiiliacS Age ElbowS BiacromialS AnkleG Gender
rvfplot, caption(Model 1a-1-2) 
		
		estat imtest, white	
		estat hettest, iid rhs		// Breush-Pagan / Cook-Weisberg, LM	

* normality	
predict r,r
kdensity r, kernel(gaussian) normal

* outliers
	*** Tukey's fences
	graph box r
	summ r, detail
		scalar iqr = r(p75) - r(p25)
		scalar lofence = r(p25) - 1.5*iqr
		scalar hifence = r(p75) + 1.5*iqr
		di "Low fence = " lofence ", High fence = " hifence
		// Only DC's residual value is outside of the fences.
		
		*** Probabilty outside fences if value are normally distributed.
			di 2*(1-normal(invnormal(.75)*(2*1.5+1))) 
	gen flag = 1 if r > hifence | r < lofence
	table flag // 5 outliers 
	
	summ ChestDepthS,d
	summ ChestDepthS if flag == 1,d

* leverage
	predict lev, leverage
		sort lev
		hilo lev , show(10) high
	
	* Suggested cut-point for leverage
	global lev_cut = (2*e(df_m)+2)/e(N)  // (2*p+2)/n
	display $lev_cut
	list Weight if lev > $lev_cut

	lvr2plot,  yline($lev_cut, lcolor(blue) lpattern(dash)) 
		            // Red lines depict averages of the axis measure		

* influence

	predict cooksd, cooksd

	* Cook's Distance
	sort cooksd
	hilo cooksd, high
	* Common cut-off:
		di 4/(e(N)-e(df_m)-1)					

drop flag
gen flag = 1 if cooksd > 0.00806
tab flag		

summ cooksd if flag == 1
	
* cross validation
crossfold regress lWeight ChestDepthS KneeG ChestS Height BitrochantericS ///
 WristG BiiliacS Age ElbowS BiacromialS AnkleG Gender, k(10) r2
		matrix m = J(1,10,1/10)*r(est) // Average Psuedo-R2
		matrix list m
	
****************
* Model 1a-2-2 *
****************

reg lWeight sq_sum_G_height Age
rvfplot

		estat hettest, iid rhs		// Breush-Pagan / Cook-Weisberg, LM	

* normality	
drop r
predict r,r
kdensity r, kernel(gaussian) normal

* outliers
	*** Tukey's fences
	graph box r
	summ r, detail
		scalar iqr = r(p75) - r(p25)
		scalar lofence = r(p25) - 1.5*iqr
		scalar hifence = r(p75) + 1.5*iqr
		di "Low fence = " lofence ", High fence = " hifence

		
		*** Probabilty outside fences if value are normally distributed.
			di 2*(1-normal(invnormal(.75)*(2*1.5+1))) 
	drop flag
	gen flag = 1 if r > hifence | r < lofence
	table flag // 5 outliers 
	
	summ ChestDepthS,d
	summ ChestDepthS if flag == 1,d

* leverage
	drop lev
	predict lev, leverage
		sort lev
		hilo lev , show(10) high
	
	* Suggested cut-point for leverage
	global lev_cut = (2*e(df_m)+2)/e(N)  // (2*p+2)/n
	display $lev_cut
	list Weight if lev > $lev_cut

	lvr2plot,  yline($lev_cut, lcolor(blue) lpattern(dash)) 
		            // Red lines depict averages of the axis measure		

* influence
	drop cooksd
	predict cooksd, cooksd

	* Cook's Distance
	sort cooksd
	hilo cooksd, high
	* Common cut-off:
		di 4/(e(N)-e(df_m)-1)					

drop flag
gen flag = 1 if cooksd > 0.00806
tab flag		

summ cooksd if flag == 1
		
* cross validation
crossfold regress lWeight sq_sum_G_height Age, k(10) r2
		matrix m = J(1,10,1/10)*r(est) // Average Psuedo-R2
		matrix list m


********************************************************************************
* Mindy's code
********************************************************************************


***********************************************
* AIM 2: MODEL SELECTION*
***********************************************

*Gender

 tab Gender
 
**Models with Height 
 
 *Model with all of the variables
 logistic Gender BiacromialS-AnkleS Height
 estat ic
 estat classification
 
 *** Stepwise, starting forward
 xi: stepwise, pe(.10) pr(.25) forward: logit Gender BiacromialS-AnkleS Height
 estat ic
 estat classification
								
 *** Stepwise, starting backward
 xi: stepwise, pe(.10) pr(.25): logit Gender BiacromialS-AnkleS Height
 estat ic
 estat classification

**Models without Height

 *Model with all skeletal variables
 logistic Gender BiacromialS-AnkleS
 estat ic
 estat classification
 
 *** Stepwise, starting forward
 xi: stepwise, pe(.10) pr(.25) forward: logit Gender BiacromialS-AnkleS
 // ElbowS BiacromialS BitrochantericS ChestDepthS AnkleS WristS KneeS
 
 estat ic
 estat classification

 *** Stepwise, starting backward
 xi: stepwise, pe(.10) pr(.25): logit Gender BiacromialS-AnkleS
 //BiacromialS KneeS BitrochantericS ChestDepthS AnkleS ElbowS WristS
 
 estat ic
 estat classification
 
**Check diagnostics with nestreg

 nestreg, lr: logit Gender (ElbowS BiacromialS BitrochantericS ChestDepthS Height WristS KneeS) (BiiliacS AnkleS) (ChestS)

**Prediction model with height included 

 logistic Gender ElbowS BiacromialS BitrochantericS ChestDepthS Height WristS KneeS
 estat classification

 /*Logistic model for Gender

              -------- True --------
Classified |         D            ~D  |      Total
-----------+--------------------------+-----------
     +     |       237            12  |        249
     -     |        10           248  |        258
-----------+--------------------------+-----------
   Total   |       247           260  |        507

Classified + if predicted Pr(D) >= .5
True D defined as Gender != 0
--------------------------------------------------
Sensitivity                     Pr( +| D)   95.95%
Specificity                     Pr( -|~D)   95.38%
Positive predictive value       Pr( D| +)   95.18%
Negative predictive value       Pr(~D| -)   96.12%
--------------------------------------------------
False + rate for true ~D        Pr( +|~D)    4.62%
False - rate for true D         Pr( -| D)    4.05%
False + rate for classified +   Pr(~D| +)    4.82%
False - rate for classified -   Pr( D| -)    3.88%
--------------------------------------------------
Correctly classified                        95.66%
--------------------------------------------------
*/

 lroc, connect(stepstair) //post logistic regression command, need to run regression first
 lsens
 
 lroc, recast(line)
 
*Prediction model without height

 logistic Gender BiacromialS KneeS BitrochantericS ChestDepthS AnkleS ElbowS WristS
 estat classification
 
 /*Logistic model for Gender

              -------- True --------
Classified |         D            ~D  |      Total
-----------+--------------------------+-----------
     +     |       237            13  |        250
     -     |        10           247  |        257
-----------+--------------------------+-----------
   Total   |       247           260  |        507

Classified + if predicted Pr(D) >= .5
True D defined as Gender != 0
--------------------------------------------------
Sensitivity                     Pr( +| D)   95.95%
Specificity                     Pr( -|~D)   95.00%
Positive predictive value       Pr( D| +)   94.80%
Negative predictive value       Pr(~D| -)   96.11%
--------------------------------------------------
False + rate for true ~D        Pr( +|~D)    5.00%
False - rate for true D         Pr( -| D)    4.05%
False + rate for classified +   Pr(~D| +)    5.20%
False - rate for classified -   Pr( D| -)    3.89%
--------------------------------------------------
Correctly classified                        95.46%
--------------------------------------------------
*/

 lroc, connect(stepstair) //post logistic regression command, need to run regression first
 lsens
 
 lroc, recast(line)
 
**Validation with height

 logistic Gender ElbowS BiacromialS BitrochantericS ChestDepthS Height WristS KneeS
 predict pred, p
 
 crossfold logistic Gender ElbowS BiacromialS BitrochantericS ChestDepthS Height WristS KneeS, k(10) r2
		matrix m = J(1,10,1/10)*r(est) // Average Psuedo-R2
		matrix list m
		
//Randomly divide into training and test sets
	set seed 745868
	gen rand_num = uniform() //uniform random number between 0 and 1
	egen ordering = rank(rand_num)
	gen group = ""
	replace group = "Train" if ordering <= _N/2 //_N is the size of the dataset
	replace group = "Test" if ordering > _N/2

	logistic Gender ElbowS BiacromialS BitrochantericS ChestDepthS Height WristS KneeS if group=="Train"
		predict pred
		quietly corr Gender pred if group=="Test"
		di r(rho)^2
		
	twoway (scatter Gender pred if group=="Train")              ///
			  (lfit Gender pred if group=="Train")              ///
		   (scatter Gender pred if group=="Test", mcolor(red))  ///
			  (lfit Gender pred if group=="Test")

**Validation without height

 logistic Gender BiacromialS KneeS BitrochantericS ChestDepthS AnkleS ElbowS WristS
	crossfold logistic Gender BiacromialS KneeS BitrochantericS ChestDepthS AnkleS ElbowS WristS, k(10) r2
		matrix m = J(1,10,1/10)*r(est) // Average Psuedo-R2
		matrix list m		  
			  
*Other
swboot Gender ElbowS BiacromialS BitrochantericS ChestDepthS Height WristS KneeS, reps(100) forward pr(.25) pe(.10) roc

***********************************************
* DESCRIPTIVES *
***********************************************
	
graph box Height Weight BMI, over(Gender)
graph box Weight, over(Gender)
graph box BMI, over(Gender)
graph box Age, over(Gender)

graph box BiacromialS BiiliacS BitrochantericS ChestDepthS ChestS ElbowS WristS KneeS AnkleS, over(Gender)

graph box ShoulderG ChestG WaistG NavelG HipG ThighG BicepG ForearmG KneeG CalfG AnkleG WristG, over(Gender)


gen bmi_cat=.
replace bmi_cat=0 if BMI<18.5
replace bmi_cat=1 if BMI>=18.5 & BMI<25
replace bmi_cat=2 if BMI>=25 & BMI<30
replace bmi_cat=3 if BMI>=30

label define bmilab 0 "Less than 18.5" 1 "18.5-25" 2 "25-30" 3 "Over 30"
label values bmi_cat bmilab

tab bmi_cat
by Gender, sort: tab bmi_cat

corr WristG WristS
corr KneeS KneeG
corr AnkleS AnkleG
corr ChestS ChestG
corr BiiliacS BitrochantericS
corr WaistG NavelG
corr ChestG BicepG if Gender==1
corr ThighG HipG if Gender==0

**Table 1

 by Gender, sort: sum BiacromialS, detail
 sum BiacromialS, detail
 
 by Gender, sort: sum BiiliacS, detail
 sum BiiliacS, detail
 
 by Gender, sort: sum BitrochantericS, detail
 sum BitrochantericS, detail
 
 by Gender, sort: sum ChestDepthS, detail
 sum ChestDepthS, detail
 
 by Gender, sort: sum ChestS, detail
 sum ChestS, detail
 
 by Gender, sort: sum ElbowS, detail
 sum ElbowS, detail
 
 by Gender, sort: sum WristS, detail
 sum WristS, detail
 
 by Gender, sort: sum KneeS, detail
 sum KneeS, detail
 
 by Gender, sort: sum AnkleS, detail
 sum AnkleS, detail
 
 by Gender, sort: sum ShoulderG, detail
 sum ShoulderG, detail
 
 by Gender, sort: sum ChestG, detail
 sum ChestG, detail
 
 by Gender, sort: sum WaistG, detail
 sum WaistG, detail
 
 by Gender, sort: sum NavelG, detail
 sum NavelG, detail
 
 by Gender, sort: sum HipG, detail
 sum HipG, detail
 
 by Gender, sort: sum ThighG, detail
 sum ThighG, detail
 
 by Gender, sort: sum BicepG, detail
 sum BicepG, detail
 
 by Gender, sort: sum ForearmG, detail
 sum ForearmG, detail
 
 by Gender, sort: sum KneeG, detail
 sum KneeG, detail
 
 by Gender, sort: sum CalfG, detail
 sum CalfG, detail
 
 by Gender, sort: sum AnkleG, detail
 sum AnkleG, detail
 
 by Gender, sort: sum WristG, detail
 sum WristG, detail
 
 by Gender, sort: sum Age, detail
 sum Age, detail
 
 by Gender, sort: sum Weight, detail
 sum Weight, detail
 
 by Gender, sort: sum Height, detail
 sum Height, detail
 
 by Gender, sort: sum BMI, detail
 sum BMI, detail
 
 by Gender, sort: tab bmi_cat
 tab bmi_cat
 
 
********************************************************************************
* Damen's code
********************************************************************************


reg lWeight ChestDepthS KneeG ChestS Height BitrochantericS WristG BiiliacS Age ElbowS BiacromialS AnkleG Gender
predict weight_bd2
twoway (scatter BMI weight_bd2)

reg lWeight ChestDepthS KneeG ChestS BitrochantericS BiiliacS WristG ElbowS Age Gender AnkleG
predict lweight_bd

reg lweight_bd BMI 
reg lweight_bd BMI WaistG ForearmG Gender

gen weight_bd=exp(lweight_bd)
twoway (scatter weight_bd BMI )
twoway (scatter weight_bd BMI if Gender==1,mcolor(blue)) (scatter weight_bd BMI if Gender==0,mcolor(red)), ///
	legend(label(1 male) label(2 female)) 

gen weight_dif = Weight - weight_bd
twoway (scatter  weight_dif BMI if Gender==1,mcolor(blue)) (scatter weight_dif BMI if Gender==0,mcolor(red)), ///
	legend(label(1 male) label(2 female)) 

reg weight_bd BMI
reg weight_dif BMI


* Fat status: Predicted body build waist
reg WaistG ChestS BiiliacS BitrochantericS ChestDepthS
predict WaistG_bd
predict Waist_dif,r
// adjusted-R2 0.776
twoway (scatter BMI Waist_dif if Gender==1,mcolor(blue) xline (-5 5)) (scatter BMI Waist_dif if Gender==0,mcolor(red)) , ///
	legend(label(1 male) label(2 female)) 


gen BMI4=.
replace BMI4=1 if BMI<=20 & BMI>0
replace BMI4=2 if BMI<=25 & BMI>20
replace BMI4=3 if BMI<=30 & BMI>25
replace BMI4=4 if BMI<=100 & BMI>30
label define bmilabel 1 "BMI<=20" 2 "20<BMI<=25" 3 "25<BMI<=30" 4 "BMI>30"
label value BMI4 bmilabel 


tab BMI4 if Waist_dif>5 // 42.5% people with high fat mass are not classified as overweight
tab BMI4 if Waist_dif>10 // 30% people with high fat mass are not classified as overweight

tab BMI4 if Waist_dif<-5 // 16.5% people with low fat mass are classified as underweight
tab BMI4 if Waist_dif<-10 // 27.3% people with low fat mass are classified as underweight


*Muscle status
reg ForearmG WristS ChestS ChestDepthS // adjusted-R2 0.787
predict Forearm_dif, r
label var Waist_dif "Forearm_ girth difference (muscle status)"

twoway (scatter BMI Forearm_dif if Gender==1,mcolor(blue)) (scatter BMI Forearm_dif  if Gender==0,mcolor(red)), ///
	legend(label(1 male) label(2 female)) 

tab BMI4 if Forearm_dif>1 // 44.3% people with high muscle mass are classified as overweight
tab BMI4 if Forearm_dif<-1 // 19.5% people with low muscle mass are classified as underweight











