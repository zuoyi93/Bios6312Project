***************************************************
 * Variable Selection
 * Author: Bob Johnson
 * Date: 02-27-2018
 * File name: "Variable Selection.do"
 * Note: For use in Notes-8
***************************************************

*/********************************************************************************
Vocabulary data

Small children show a very high variation in the development of early vocabulary.
Some children start to talk very early and have at the age of 2.5 years a 
vocabulary of several hundred words, whereas other children may have just started
to use words. Many studies have shown that parental input and parental activities
play a role in explaining this variation, and that differences in vocabulary
development are associated with differences in the parents' socio-economic status.

The data set vocabulary includes information on the vocabulary size of 2.5
year-old children, which has been measured by parental checklist reports. The
parents have been classified by the highest education in the family and their
income. Parents were asked how much time they spend reading books to their child
each week and how much the child is exposed to television each day. Parents were
also asked about how many days each week they sing a song with the child, how
much time does the father (or mother if the father is the primary care taker of
the child) spend each day with the child, and how much time does the child spend
each day with other children. Additionally, information on the sex of the child
is recorded.
*********************************************************************************/
cd "/home/bob/Dropbox/__Regression/Class Notes/Notes 8 supplemental"
use "vocabulary.dta", clear
summ

*** Can we model the number of words in child's vocabulary?
regress numwords i.sex i.edu i.income Sing Father Child Read TVtime
	scalar params = e(df_m) // Degrees of freedom for the model = number of regressors (if X is full rank)
	scalar sampsize =  e(N) // Number of observations
	global lev_cut = (2*params+2)/sampsize
	display $lev_cut
	lvr2plot, mlabel(id) yline($lev_cut, lcolor(blue) lpattern(dash)) name(influence, replace)

*** Examples of stepwise regression
    *** Forward selection
	xi: stepwise, pe(.15): regress numwords (i.sex) (i.edu) (i.income) ///
						Sing Father Child Read TVtime
    *** Backward elimination
	xi: stepwise, pr(.15): regress numwords (i.sex) (i.edu) (i.income) ///
						Sing Father Child Read TVtime
    *** Stepwise, starting backward
	xi: stepwise, pe(.10) pr(.25): regress numwords (i.sex) (i.edu) (i.income) ///
							Sing Father Child Read TVtime
    *** Stepwise, starting forward
	xi: stepwise, pe(.10) pr(.25) forward: regress numwords (i.sex) (i.edu) (i.income) ///
								Sing Father Child Read TVtime
    *** Backward stepwise, requiring TVtime to be in the model
	xi: stepwise, pe(.10) pr(.25) lockterm1: regress numwords TVtime (i.sex) (i.edu) (i.income) ///
								  Sing Father Child Read 
    *** Forward stepwise, requiring the demographic variables to be in the model
	xi: stepwise, pe(.10) pr(.25) forward lockterm1: regress numwords (i.sex i.edu i.income)    ///
									  Sing Father Child Read TVtime  

    *** Another approach, using information criteria
    
	*** Build the model step by step. Select the variable most correlated with dependent variable.
	xi: corr numwords i.sex i.edu i.income Sing Father Child Read TVtime 
	regress numwords TVtime // i.sex i.edu i.income Sing Father Child Read
		estimates store mod1
		predict r1, r
	*** Next, select the variable most correlated with the residual of the last regression.
	xi: corr r1 i.sex i.edu i.income Sing Father Child Read TVtime 
	regress numwords TVtime Father // i.sex i.edu i.income Sing Child Read
		estimates store mod2
		predict r2, r
	*** Etcetera...
	xi: corr r2 i.sex i.edu i.income Sing Father Child Read TVtime 
	regress numwords TVtime Father Sing // i.sex i.edu i.income Child Read
		estimates store mod3
		predict r3, r
	*** ...
	xi: corr r3 i.sex i.edu i.income Sing Father Child Read TVtime 
	regress numwords TVtime Father Sing i.income // i.sex i.edu Child Read
		estimates store mod4
		predict r4, r
	*** ...
	xi: corr r4 i.sex i.edu i.income Sing Father Child Read TVtime 
	regress numwords TVtime Father Sing i.income i1.sex // i.edu Child Read
		estimates store mod5
		predict r5, r
	*** ...
	xi: corr r5 i.sex i.edu i.income Sing Father Child Read TVtime 
	regress numwords TVtime Father Sing i.income i1.sex Child // i.edu Read
		estimates store mod6
		predict r6, r

	*** Combine the AIC, AICc, BIC, and more in a summary table.
	est table mod*, stats(aic)

	*** Accomplish the above with one command. Use 'findit vselect' to install.
	xi: vselect numwords i.sex i.edu i.income Sing Father Child Read TVtime, forward aic

	*** Look at all models to find the 'best'.
	xi: vselect numwords i.sex i.edu i.income Sing Father Child Read TVtime, best
	

*** Look at relationships between AIC, AICc, BIC, and C	
clear all
input id r2adj c aic aicc bic
         1  .1410348  52.06081  4116.047   4116.12  4123.657
         2  .1808803  35.33234   4101.27  4101.392  4112.685
         3    .21499  21.23322  4088.138  4088.322  4103.359
         4  .2344634  13.64274  4080.785  4081.043   4099.81
         5  .2499062  7.866269  4075.002  4075.348  4097.833
         6  .2559526  6.225762  4073.295  4073.741  4099.931
         7  .2571028  6.728494  4073.758  4074.317  4104.199
         8  .2569629  7.793004  4074.794   4075.48  4109.041
         9  .2550501  9.622549  4076.619  4077.444   4114.67
        10  .2541759        11  4077.975  4078.953  4119.832
end

twoway (scatter c aic) (lfit c aic)
	regress c aic, coeflegend
twoway (scatter bic aicc aic id) (scatter c id, yaxis(2))



*** Variable selection methods based on shrinkage and related

import delimited using http://users.stat.umn.edu/~sandy/alr4ed/data/Highway.csv, clear

	* Transform some of the measures.
	gen lrate=log(rate)
	gen llen=log(len)
	gen ltrks=log(trks)
	gen ladt=log(adt)

*** I am not impressed with this package nor with the corresponding documentation.
	lars lrate llen ltrks ladt adt lane acpt sigs itg slim lwid shld
	lars lrate llen ltrks ladt adt lane acpt sigs itg slim lwid shld, a(lasso)
	lars lrate llen ltrks ladt adt lane acpt sigs itg slim lwid shld, a(stagewise)

