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

*********************************************
* Model selection using best without height *
*********************************************

vselect lWeight BiacromialS-AnkleS Gender Age, best
// ChestDepthS ChestS KneeS BitrochantericS Age BiiliacS WristS ElbowS

vselect lWeight BiacromialS BiiliacS BitrochantericS ChestDepthS ChestS ElbowS   ///
AnkleG KneeG WristG Gender Age, best

// ChestDepthS KneeG ChestS BitrochantericS BiiliacS WristG ElbowS Age Gender AnkleG

* Comparison of two models
reg lWeight ChestDepthS ChestS KneeS BitrochantericS Age BiiliacS WristS ElbowS
estat ic
// AIC: -1320.389, BIC: -1282.332
rvfplot

reg lWeight ChestDepthS KneeG ChestS BitrochantericS BiiliacS WristG ElbowS Age Gender AnkleG
estat ic
// AIC: -1461.679, BIC: -1415.166
rvfplot


* Backward selection using AIC 

vselect lWeight BiacromialS-AnkleS Gender Age, backward aic
// -1302.705


vselect lWeight BiacromialS BiiliacS BitrochantericS ChestDepthS ChestS ElbowS   ///
AnkleG KneeG WristG Gender Age, backward aic
// -1454.812

// same model as `best`

*********************************************
* Model selection using best with height *
*********************************************

vselect lWeight BiacromialS-AnkleS Gender Age Height, best
// ChestDepthS ChestS KneeS BitrochantericS Age BiiliacS WristS ElbowS
// ChestDepthS ChestS KneeS BitrochantericS Height WristS Age BiiliacS BiacromialS

vselect lWeight BiacromialS BiiliacS BitrochantericS ChestDepthS ChestS ElbowS   ///
AnkleG KneeG WristG Gender Age Height, best

// ChestDepthS KneeG ChestS BitrochantericS BiiliacS WristG ElbowS Age Gender AnkleG
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

reg lWeight ChestDepthS KneeG ChestS BitrochantericS BiiliacS WristG ElbowS Age Gender AnkleG
rvfplot, caption(Model 1a-1-2) 

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
	table flag // 6 outliers 
	
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
		






