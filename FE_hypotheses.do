****
*FE*
****

*2015 RECODED

gen r_syear = syear 
replace r_syear = 20155 if syear == 2015 & imonth <= 5
replace r_syear = 20156 if syear == 2015 & imonth >= 6

************
*FE - WORMI*
************

************
*Null Model*
************

xtreg v_wormi i.r_syear, fe cluster(pid) allbaselevels
eststo NullModel

*********************
*FE with crime (HY1)*
*********************

xtreg v_wormi v_wocri i.r_syear, fe cluster(pid) allbaselevels
eststo Model1

*******************
*FE with eco (HY2)*
*******************

xtreg v_wormi v_wocri v_woeco loghhincome i.r_syear, fe cluster(pid) allbaselevels
eststo Model2

*******************
*FE with eco (HY2)*
*******************

xtreg v_wormi v_wocri v_woeco loghhincome i.emplstus i.regun i.r_syear, fe cluster(pid) allbaselevels
eststo Model3

*******************
*FE with eco (HY2)*
*******************

xtreg v_wormi v_wocri v_woeco loghhincome i.emplstus i.regun ib3.edu_level i.r_syear, fe cluster(pid) allbaselevels
eststo Model4

esttab NullModel Model1 Model2 Model3 Model4 using results_new.rtf, replace se label




*************
*FE - WHOSMI*
*************

************
*Null Model*
************

xtreg v_whosmi i.r_syear, fe cluster(pid) allbaselevels
eststo NullModel

*********************
*FE with crime (HY1)*
*********************

xtreg v_whosmi v_wocri i.r_syear, fe cluster(pid) allbaselevels
eststo Model1

*******************
*FE with eco (HY2)*
*******************

xtreg v_whosmi v_wocri v_woeco loghhincome i.r_syear, fe cluster(pid) allbaselevels
eststo Model2

*******************
*FE with eco (HY2)*
*******************

xtreg v_whosmi v_wocri v_woeco loghhincome i.emplstus i.regun i.r_syear, fe cluster(pid) allbaselevels
eststo Model3

*******************
*FE with eco (HY3)*
*******************

xtreg v_whosmi v_wocri v_woeco loghhincome i.emplstus i.regun ib3.edu_level i.r_syear, fe cluster(pid) allbaselevels
eststo Model4

esttab NullModel Model1 Model2 Model3 Model4 using results_new.rtf, replace se label


