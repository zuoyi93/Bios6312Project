***************************************************
 * Logistic Regression
 * Author: Bob Johnson
 * Date: Modifed 03-28-2018
 * File name: "Logistic Regression.do"
 * Note: For use in Notes-12
***************************************************

cd "/Volumes/GoogleDrive/My Drive/Vanderbilt/2nd Semester 2018-2019/Bios6312_Regression/Mar. 19"

use Sepsis, clear
describe
codebook

summ apache if fate==0
summ apache if fate==1
graph box apache, over(fate)
twoway (scatter fate apache) (lfit fate apache)

logit fate apache	    // Reports regression coefficients
logistic fate apache	// Reports odds ratios
	logistic, coef      // Can still view regression coefficients
	predict p
	twoway (scatter fate apache) (line p apache, sort), ///
		title(Predicted Probabilities)


// Grouped data

use Sepsis_grouped, clear
describe
codebook
	blogit deaths patients apache
		blogit, or		// 'or' requests the odds ratios
		predict p_hat, pr

	gen grp_p =  deaths/patients
	scatter p_hat grp_p

// Logistic regression as a generalized linear model

use http://www.stata-press.com/data/r13/lbw.dta, clear
describe
codebook

	logit low age i.race##i.smoke
	  logit, or						//View the ORs
		contrast smoke#race
		margins smoke#race
			marginsplot

			
	// Repeat the analysis as a GLM
	glm low age i.race##i.smoke, family(binomial 1) link(logit)
		estimates store A
		scalar dev1=e(deviance)
		scalar df1=e(df)
		di "Deviance=" dev1 ", df=" df1, ", GOF p-value=" chiprob(df1,dev1)


	// Deviance test (Likelihood ratio test) for coefficient on Age
	glm low i.race##i.smoke, family(binomial 1) link(logit)
		lrtest A
		scalar dev0=e(deviance)
		scalar df0=e(df)
		di "Deviance difference=" dev0-dev1 ", df=" df0-df1 ", Age p-value=" ///
			chiprob(df0-df1,dev0-dev1)
			
	// Bayesian logistic regression with non-informative priors		
	bayes: logit low age i.race##i.smoke
		bayesgraph diagnostics {low:i.smoke}

// Propensity Score Matching (we may not cover this in class)
	use http://ssc.wisc.edu/sscc/pubs/files/psm
		describe
		graph box y, over(t)
	ttest y, by(t)
	
	// Control for covariables, X1 and X2.
		twoway (sunflower y x1) (lowess y x1)
		twoway (sunflower y x2) (lowess y x2)
		sunflower x1 x2
		regress y i.t x1 x2
			margins t
	
	// This is an observational study. Subjects are not randomized to treatment.
		by t, sort: summ x1 x2
		graph box x1 x2, over(t)
		
	// Can we "predict" treatment group using X1 and X2?
		logit t x1 x2
			predict pp
			predict lpp, xb
			graph box lpp, over(t)
			
	// Use propensity score matching. Test the difference in mean "y" between
	// treated and untreated via 1-1 matching on propensity score.
		teffects psmatch (y) (t x1 x2)

	// Let's take a look under the hood.
	*	use http://ssc.wisc.edu/sscc/pubs/files/psm, replace
		// Generate a matching variable. The value of match indicates which
		// observation the 
		quietly: teffects psmatch (y) (t x1 x2), gen(match)
			predict ps0 ps1, ps
			predict y0 y1, po
			predict te
			// ps1 is the propensity for T=1. This is the same as pp from 
			// the logistic regression.
				list ps1 pp if _n <= 5
		// Take a look at the matching
			gen ob=_n
			list ob match1 t y0 y1 ps1 if t==1 & match1==10
				list ob match1 t y0 y1 ps1 if ob==10

	// Another approach is to use the propensity score to construct cubic, say, 
	// splines and then use the splines in a regression.
		bspline, xvar(ps1) knots(0 .25 .50 .75 1) p(3) gen(psspl)
	
		twoway (sunflower y pp) (lfit y pp)
		twoway (sunflower y lpp) (lfit y lpp)
		regress y i.t x1 x2 psspl2-psspl7
			margins t
