global Wdata "/Users/andreazuliani/Desktop/New_research/Wdata"
use "$Wdata/recodata", clear

**********
*PRE-TEST*
**********

********************************
*Pre-test 2013-2015a with WORMI*
********************************

regress v_wormi i.prepre_event i.pre_event i.event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
	
**************************************
*PARALLEL TREND ASSUMPTION with WORMI*
**************************************

*We computed the 2014 coefficient
dis 1.923352-1.874279 

*We computed the expected value of Y in 2015a 
dis .049073+1.923352

*We divided the difference of Y2015a and Y under the assumption of linear growth
dis 2.033042-1.972425

*We are testing parallel trend assumption if the results is 0 it is respected. We have .060617, so we can say it is maintainable

*********************************
*Pre-test 2013-2015a with WHOSMI*
*********************************

regress v_whosmi i.prepre_event i.pre_event i.event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
***************************************
*PARALLEL TREND ASSUMPTION with WHOSMI*
***************************************

*We computed the 2014 coefficient
dis 2.01078-2.007771

*We computed the expected value of Y in 2015a 
dis .003009+2.01078

*We divided the difference of Y2015a and Y under the assumption of linear growth
dis 2.202192-2.013789

*we are testing parallel trend assumption if the results is 0 it is respected. we have .188403, so we can say it is hardly maintainable.

************
*PTA GRAPHS*
************

*******
*WORMI*
*******

regress v_wormi i.prepre_event i.pre_event i.event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
marginsplot, ///
     xlabel(1 "2013" 2 "2014" 3 "2015a") ///
     title("Worries about immigration to Germany by years") ///
     ytitle("Worries about immigration") ///
	 xtitle ("Years") ///
     name(g1, replace)	 

********
*WHOSMI*
********

regress v_whosmi prepre_event pre_event event_0

margins, at(prepre_event=1 pre_event=0 event_0=0) ///
         at(prepre_event=0 pre_event=1 event_0=0) ///
         at(prepre_event=0 pre_event=0 event_0=1) 	 
	 
marginsplot, ///
     xlabel(1 "2013" 2 "2014" 3 "2015a") ///
     title("Worries about hostility towards foreigners by years") ///
     ytitle("Worries about hostility towards foreigners") ///
	 xtitle ("Years") ///
     name(g2, replace)	 
	 
graph combine g1 g2, cols(2) title("PTA Test") ycommon
	 
*******************************
*Pre-test 2013-2016 with WORMI*
*******************************

regress v_wormi prepre_event pre_event event_0 event_1 post_event

estimates store model1

coefplot model1, keep(prepre_event pre_event event_0 event_1 post_event) ///
    vertical ytitle("Coefficient") ///
    yline(0) ciopts(recast(rcap)) ///
    title("Effect of Event Timing on Outcome") ///
    note("Controls included: [list your controls]")

margins, at(prepre_event=1 pre_event=0 event_0=0 event_1=0 post_event=0) ///
         at(prepre_event=0 pre_event=1 event_0=0 event_1=0 post_event=0) ///
         at(prepre_event=0 pre_event=0 event_0=1 event_1=0 post_event=0) ///
		 at(prepre_event=0 pre_event=0 event_0=0 event_1=1 post_event=0) ///
		 at(prepre_event=0 pre_event=0 event_0=0 event_1=0 post_event=1)

marginsplot, ///
     xlabel(1 "2013" 2 "2014" 3 "2015a" 4"2015b" 5"2016") ///
     title("Worries about immigration by years") ///
     ytitle("Worries about immigration") ///
	 xtitle("Years") ///
     name(g11, replace)		 
		 
dis 2.113588 -2.033042 	
di	.080546+2.113588
di 2.322199-2.194134
*.128065

********************************
*Pre-test 2013-2016 with WHOSMI*
********************************

regress v_whosmi prepre_event pre_event event_0 event_1 post_event

estimates store model1

coefplot model1, keep(prepre_event pre_event event_0 event_1 post_event) ///
    vertical ytitle("Coefficient") ///
    yline(0) ciopts(recast(rcap)) ///
    title("Effect of Event Timing on Outcome") ///
    note("Controls included: [list your controls]")

margins, at(prepre_event=1 pre_event=0 event_0=0 event_1=0 post_event=0) ///
         at(prepre_event=0 pre_event=1 event_0=0 event_1=0 post_event=0) ///
         at(prepre_event=0 pre_event=0 event_0=1 event_1=0 post_event=0) ///
		 at(prepre_event=0 pre_event=0 event_0=0 event_1=1 post_event=0) ///
		 at(prepre_event=0 pre_event=0 event_0=0 event_1=0 post_event=1)

marginsplot, ///
     xlabel(1 "2013" 2 "2014" 3 "2015a" 4"2015b" 5"2016") ///
     title("Worries about hostility towards foreigners by years") ///
     ytitle("Worries about hostility towards foreigners") ///
	 xtitle("Years") ///
     name(g12, replace)		

graph combine g11 g12, cols(2) title("FD Test") ycommon	 

di 2.259847-2.202192
di 2.259847+.057655
di 2.405365 -2.317502
*.087863

save "$Wdata/recodata", replace 
