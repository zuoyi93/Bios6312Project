***************************************************
 * Model Validation
 * Author: Bob Johnson
 * Date: 03-13-2018
 * File name: "Validation.do"
 * Note: For use in Notes-9
***************************************************

/*** Data: 1999 API (Academic Performace Index) data for Orange County high schools.
	   There are 71 observations, but parents' (average) education is missing 
	   for 4 schools. We will seek to validate models that predict API99.
***/
	use http://www.philender.com/courses/data/ochi, clear
	describe
	misstable summarize api99 pctmeal pctel yrrnd core avged pctemer

*** Apparent validity

	** R2 = 0.886, no dicernible pattern in residual plot. 
	regress api99 pctmeal pctel yrrnd core avged pctemer
		predict pred
		rvfplot
	twoway (scatter api99 pred) (lfit api99 pred), name(org, replace)
	
*** External validation 
	/** Similar data for Los Angeles County high schools, same period. There
	    are missing values on parents' education (4) and on core class sizes (6).
	**/
	use http://www.philender.com/courses/data/lahi, clear
	misstable summarize api99 pctmeal pctel yrrnd core avged pctemer

	** Predict API99 schools using training model. 
	predict prdval
	qui corr api99 prdval
	di r(rho)^2		// R^2 value using validation set
	** Note the nonlinear pattern.
	twoway (scatter api99 prdval) (lfit api99 prdval), name(val, replace)

  ** Alternate method, combining the data first
	use http://www.philender.com/courses/data/ochi, clear
		count
	append using http://www.philender.com/courses/data/lahi

	gen sample=1 if _n<72
	replace sample=2 if _n>71

	regress api99 pctmeal pctel yrrnd core avged pctemer if sample==1
		predict pred
	twoway (scatter api99 pred if sample==1) (lfit api99 pred if sample==1) ///
	       (scatter api99 pred if sample==2) (lfit api99 pred if sample==2)
		   
	qui corr api99 pred if sample==2
	di r(rho)^2		// R^2 value using validation set


*** Internal validation, random training and testing sets

	use http://www.philender.com/courses/data/ochi, clear
	drop if avged==.

	set seed 745868
	gen rand_num = uniform() 
	egen ordering = rank(rand_num)
	gen group = ""
	replace group = "Train" if ordering <= _N/2
	replace group = "Test" if ordering > _N/2

	regress api99 pctmeal pctel yrrnd core avged pctemer if group=="Train"
		predict pred
		quietly corr api99 pred if group=="Test"
		di r(rho)^2
		
	twoway (scatter api99 pred if group=="Train")              ///
			  (lfit api99 pred if group=="Train")              ///
		   (scatter api99 pred if group=="Test", mcolor(red))  ///
			  (lfit api99 pred if group=="Test")
	
	// For calibration
	twoway (scatter api99 pred if group=="Test") ///
		      (lfit api99 pred if group=="Test") ///
		      (function y=x,  lp(dash))
			  
	regress api99 pred if group=="Train"
	regress api99 pred if group=="Test"	
	
	** Alternatively, repeat this process many times 
	** (1 for comparison, then 100 times)
		regress api99 pctmeal pctel yrrnd core avged pctemer
		regvalidate, reps(1) seed(745868)  // Findit regvalidate

*** Internal k-fold validation

	use http://www.philender.com/courses/data/ochi, clear
	   drop if avged==.
   
	** findit crossfold
	crossfold regress api99 pctmeal pctel yrrnd core avged pctemer, k(10) r2
		matrix m = J(1,10,1/10)*r(est) // Average Psuedo-R2
		matrix list m

*** Internal: Simple bootstrap validation

	use http://www.philender.com/courses/data/ochi, clear
	   drop if avged==.
	   
	   regress api99 pctmeal pctel yrrnd core avged pctemer
		  global orgr2 = e(r2)
	   
	   gen wght = . // This will contain frequency counts, defining bootstrap sample
   
	   forvalues i=1(1)50 {
	      bsample, weight(wght)
	      qui regress api99 pctmeal pctel yrrnd core avged pctemer [fweight=wght]
		  global bsr2 = e(r2)
		qui predict pred
		qui corr api99 pred
		if `i'==1 matrix diff = $bsr2 - r(rho)^2
		else matrix diff = (diff \ ($bsr2 - r(rho)^2) )
		drop pred
	   }
   
	   matrix list diff
	   svmat diff // Saves the values as a variable, named diff1
	   summ diff1, detail
	
	   * R^2 for original data
			di $orgr2
       * Estimated optimism
			di r(mean)
	   * Optimism-corrected R^2
			di $orgr2 - r(mean)
