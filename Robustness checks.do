**********
*PRE-TEST*
**********
****FIRST WAY OF CREATING TIME DUMMY
ssc install coefplot
tab syear
*gen three time dummies for pret-test (conceptuall -1. 0. 1)
gen preprepre_event = (syear == 2012)
gen prepre_event = (syear == 2013)
gen pre_event = (syear == 2014)    // Year before event
gen event = (syear == 2015)        // Event year
gen post_event = (syear == 2016)   // Year after event


gen event_0 = .
replace event_0 = 1 if syear == 2015 & imonth <= 5
replace event_0 = 0 if event_0 !=1

gen event_1 = .
replace event_1 = 1 if syear == 2015 & imonth >= 6
replace event_1 = 0 if event_1 !=1

*************************

********************
*Pre-test 2013-2015a*
********************
*******
*WORMI
regress v_wormi i.prepre_event i.pre_event i.event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
	
************
****PTA****
***********
*I computed the 2014 coefficient
dis 1.923669-1.840488
*I comuted the expected value of Y in 2015a 
dis .083181+1.923669
*I divided the difference of Y2015a and Y under the assumption of linear growth
dis 2.031694-2.00685 
*we are testing parallel trend assumption if the results is 0 it is respected. we have .024844, so we can say it is maintainable. (wormi) Instead of .019247


********
*WHOSMI

regress v_whosmi i.prepre_event i.pre_event i.event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
	
************
****PTA****
***********
*I computed the 2014 coefficient
dis 1.987056-1.875443
*I comuted the expected value of Y in 2015a 
dis .111613+1.987056
*I divided the difference of Y2015a and Y under the assumption of linear growth
dis 2.179595-2.098669
*we are testing parallel trend assumption if the results is 0 it is respected. we have .080926, so we can say it is hardly maintainable. Instead of .13985

*PTA GRAPHS	
	
regress v_wormi i.prepre_event i.pre_event i.event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
marginsplot, ///
     xlabel(1 "2013" 2 "2014" 3 "2015a") ///
     title("Attitudes towards immigrants by Years") ///
     ytitle("Attitudes towards immigrants") ///
	 xtitle ("Years") ///
     name(g1, replace)	 
*	
	
regress v_whosmi prepre_event pre_event event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
marginsplot, ///
     xlabel(1 "2013" 2 "2014" 3 "2015a") ///
     title("Fear of xenophobia by Years") ///
     ytitle("Fear of xenophobia") ///
	 xtitle ("Years") ///
     name(g2, replace)	 
	 
graph combine g1 g2, cols(2) title("PTA Test") ycommon
