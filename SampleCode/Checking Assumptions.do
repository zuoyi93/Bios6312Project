***************************************************
 * Checking Assumptions
 * Author: Bob Johnson
 * Date: 01-31-2018
 * File name: "Checking Assumptions.do"
 * Note: For use in Notes-5
***************************************************


* Check model correctness
	sysuse auto, clear

	* Can we predict mpg with a linear function of weight?
	twoway (scatter mpg weight) (lfit mpg weight) (lowess mpg weight)
	regress mpg weight
		predict mpghat_wt
		predict r_wt, r
		
		twoway (scatter r_wt weight)
			rvpplot weight, name(rvp,replace)
		
	* Can we predict mpg with a linear function of weight and price?
	twoway (scatter mpg weight [w=price], ms(circle_hollow))
	gen hiprice = 0
	replace hiprice = 1 if price > 5000
	twoway (scatter mpg weight if hiprice==0) (scatter mpg weight if hiprice==1, color(red)) ///
	       (lfit mpg weight if hiprice==0) (lfit mpg weight if hiprice==1, color(red))
	capture drop r_mreg mpghat_mreg
	regress mpg weight price c.weight#c.price
		predict mpghat_mreg
		predict r_mreg,r
		
		rvfplot, name(rvf, replace) addplot(lowess r_mreg mpghat_mreg)
			
	* Look for systematic pattern in residuals
	cd "/home/bob/Dropbox/__Regression/Class Notes/Notes 5 supplemental"
	use checkmodel, clear
	
	graph matrix y x z  // Are all relationships linear?

	regress y x z
		rvfplot
		
	cprplot x, name(cpr1, replace) nodraw
	cprplot z, name(cpr2, replace) nodraw
	graph combine cpr1 cpr2, rows(2)


* Check heteroskedasticity of residuals
	sysuse auto, clear
	regress mpg weight price //c.weight#c.price
		rvfplot, yline(0)
		predict yhat
		predict rsid,r
		estat imtest, white			// Cameron & Trivedi
		estat hettest, iid rhs		// Breush-Pagan / Cook-Weisberg, LM
		
		gen r2 = rsid^2
		regress r2 weight price c.weight#c.weight c.price#c.price c.weight#c.price
		di "White's test statistic: " e(N)*e(r2)
		regress r2 weight price
		di "BP/CW's test statistic: " e(N)*e(r2)

* Issues independence of residuals
	sysuse auto, clear
	regress mpg weight price c.weight#c.price
	* About residuals
	predict r, r
	predict sr, rstandard
	predict srjk, rstudent

	scatter r weight, name(r1) nodraw
	scatter sr weight, name(r2) nodraw
	scatter srjk weight, name(r3) nodraw
	graph combine r1 r2 r3, name(resid2) ycommon

* Check normality of residuals
	kdensity r, kernel(gaussian) normal name(kd, replace)
	/* Or... */ hist r, normal kdensity
	pnorm r
	qnorm r
	swilk r
	
	use checkmodel, clear
	regress y x z
		predict r
	kdensity r, kernel(gaussian) normal name(kd, replace)
	/* Or... */ hist r, normal kdensity
	pnorm r
	qnorm r
	swilk r
			
	
