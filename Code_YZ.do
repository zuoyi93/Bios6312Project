*********************
*** Final Project *** 
*********************

* Author: Yi Zuo
* Date last modified: 03/14/2019
* cd Google\ Drive\ File\ Stream/My\ Drive/Vanderbilt/2nd\ Semester\ 2018-2019/Bios6312_Regression/Project/

********************************************************************************
* STEP ONE: DATA PREPARATION
********************************************************************************
cd "/Volumes/GoogleDrive/My Drive/Vanderbilt/2nd Semester 2018-2019/Bios6312_Regression/Project"

* import data
clear
import delimited "body.dat.txt", delimiter(" ",collapse)

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



********************************************************************************
* STEP TWO:
********************************************************************************


