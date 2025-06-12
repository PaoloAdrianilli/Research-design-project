global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
use "$Wdata/recodata.dta", clear
label language EN
xtset pid syear

findit xtfeis
ssc install xtfeis
********************************************************************************
* DESCRITPIVE OF SAMPLE AFTER HAVING DEALT WITH MISSINGS

tab syear
asdoc tab syear

********************************************************************************
* DESCRITPIVE OF HHINCOME

*Descriptives of the mean HHincome of the respondent
xtsum i11103
bysort syear: sum i11103
tabstat i11103, by(syear) stat(mean)
rename i11103 hhIncome
asdoc tabstat hhIncome, by(syear) stat(mean), replace

/*we made Income a logarithm // those who had income 0 were substituted with 
missings*/
gen loghhincome = log(hhIncome)
gen loghhincomeplus =log(hhIncome+1)
xtsum loghhincomeplus loghhincome


graph box loghhincome, over(syear) ///
    title("Household Labour Income Distribution") ///
    ytitle("Household Labour Income (log)") ///
    scheme(s1color) ///
    box(1, color(ltblue)) ///
    marker(1, mcolor(ltblue))
   

bysort syear: egen median_hhIncome = median(hhIncome)
twoway (line median_hhIncome syear), ///
    ytitle("Meidan Level of Income by Years") ///
    title("Median Level of Income") ///
	xlabel(2012(1)2018)

*Descriptives of the median HHincome of the respondent
graph bar (median) hhIncome, over(syear)
graph bar (median) hhIncome, over(syear) ///
    ytitle("Median Income") ///
    title("Median Income by Year") 


********************************************************************************
* DESCRIPTIVE AGE 

kdensity d11101, lcolor(blue) ///
    title("Kernel Density of Age")

rename d11101 age

asdoc summarize age, save(table1.doc) replace
asdoc tabulate sex, append
asdoc tabulate bex4cert, append
asdoc tabulate bothprntsgerman, append

********************************************************************************
* Two ways of plotting the same thing (I prefer the second one).   | WORRIES |
********************************************************************************
/*
graph bar (mean) v_wormi, over(syear) name(g1, replace)
graph bar (mean) v_wjose, over(syear) name(g2, replace)
graph bar (mean) v_whosmi, over(syear) name(g3, replace)
graph bar (mean) v_woeco, over(syear) name(g4, replace)
graph bar (mean) v_wocri, over(syear) name(g5, replace)

graph combine g1 g2 g3 g4 g5, cols(2) title("Means by year")
*/
foreach var in v_wormi v_whosmi v_wjose v_wocri v_woeco {
	bysort syear: egen mean_`var' = mean(`var')
}


twoway connected mean_v_wormi syear, name(g1, replace) ///
    title("Mean Concern about Migrants") ///
    ytitle("Worries about migrants", size(small)) ///
    xtitle("Years") ///
    xlabel(2012(1)2018)

twoway connected mean_v_whosmi syear, name(g3, replace) ///
    title("Mean Concern about Hostility to Foreigners") ///
    ytitle("Worries about hostility to foreigners", size(small)) ///
    xtitle("Years") ///
    xlabel(2012(1)2018)

twoway connected mean_v_wocri syear, name(g4, replace) ///
    title("Mean Concern about Crime") ///
    ytitle("Worries about crime", size(small)) ///
    xtitle("Years") ///
    xlabel(2012(1)2018)

twoway connected mean_v_woeco syear, name(g5, replace) ///
    title("Mean Concern about Economic Development") ///
    ytitle("Worries about Economic Development", size(small)) ///
    xtitle("Years") ///
    xlabel(2012(1)2018)

graph combine g1 g3 g4 g5, cols(2) title("Means by year") ycommon

********************************************************************************
* DESCRIPTIVE EDUCATION LEVEL *

tab bex4cert
tab bex4cert, missing
drop if missing(bex4cert)
graph bar (count), over(bex4cert) ///
    bar(1, color(gs14)) ///
    blabel(bar) ///
    ytitle("Number of individuals") ///
    title("Highest Education Level Achieved")
	
********************************************************************************
* DESCRIPTIVE SEX *

tab sex
graph bar (count), over(sex) blabel(bar) ///
    ytitle("Number of individuals") ///
    title("Sex Distribution")

********************************************************************************
* DESCRIPTIVE PARENTS ORIGIN *

tab bothprntsgerman
asdoc tab bothprntsgerman

********************************************************************************
* TIME DUMMY *

tab syear time_dummy
asdoc tab syear time_dummy

********************************************************************************
********************************************************************************
* DEALING WITH MISSINGS FOR TIME-CONSTANT VARIABLES *


*******
* SEX *
*******

tab sex, mi
bys pid: egen misex = total(mi(sex))
tab misex

list pid syear sex misex if misex>0, sepby(pid)

* For time-constant variables we can simply carryforward/backward 
*	non-missing information
ssc describe carryforward
ssc install carryforward

* Carry forward
bys pid (syear): carryforward sex, replace
list pid syear sex if misex>0, sepby(pid)

* Carry backward
gsort pid -syear
by pid: carryforward sex, replace

list pid syear sex if misex>0, sepby(pid)
tab sex, mi

* Drop if sex unknown
drop if sex==.
drop misex
tab sex

************************
* PARENTS FROM GERMANY *
************************

tab bothprntsgerman, mi
bys pid: egen misprnts = total(mi(bothprntsgerman))
tab misprnts

list pid syear bothprntsgerman misprnts if misprnts>0, sepby(pid)

* For time-constant variables we can simply carryforward/backward 
*	non-missing information

* Carry forward
bys pid (syear): carryforward bothprntsgerman, replace
list pid syear bothprntsgerman if misprnts>0, sepby(pid)

* Carry backward
gsort pid -syear
by pid: carryforward bothprntsgerman, replace

list pid syear bothprntsgerman if misprnts>0, sepby(pid)
tab bothprntsgerman, mi

* Drop if race unknown
drop if bothprntsgerman==.
drop misprnts

asdoc tab bothprntsgerman, replace
*****************
* YEAR OF BIRTH *
*****************

tab birthyr, mi
bys pid: egen misbirth = total(mi(birthyr))
tab misbirth

list pid syear birthyr misbirth if misbirth>0, sepby(pid)

* For time-constant variables we can simply carryforward/backward 
*	non-missing information

* Carry forward
bys pid (syear): carryforward birthyr, replace
list pid syear birthyr if misbirth>0, sepby(pid)

* Carry backward
gsort pid -syear
by pid: carryforward birthyr, replace

list pid syear birthyr if misbirth>0, sepby(pid)
tab birthyr, mi

* Drop if birthyear unknown
drop if birthyr==.
drop misbirth

gen ssyear_15 = r_syear == 20155
gen ssyear_15a = r_syear == 20156

gen ssyear_16 = r_syear == 2016

gen wocri_1 = v_wocri == 1

mediate (v_whosmi i.v_woeco, linear) ///
              (wocri_1 i.v_woeco, logit) ///
			  (ssyear_16)

********
*FE*FEIS
********

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

xtfeis v_wormi i.r_syear, cluster(pid) 
*********************
*FE with crime (HY1)*
*********************

xtreg v_wormi i.v_wocri##i.syear, fe cluster(pid) allbaselevels
eststo Model1

xtfeis v_wormi i.v_wocri i.r_syear, cluster(pid)
*******************
*FE with eco (HY2)*
*******************

xtreg v_wormi i.v_wocri i.v_woeco loghhincome i.r_syear, fe cluster(pid) allbaselevels
eststo Model2

xtfeis v_wormi i.v_wocri i.v_woeco loghhincome i.r_syear, cluster(pid)
*******************
*FE with eco (HY2)*
*******************

xtreg v_wormi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun i.r_syear, fe cluster(pid) allbaselevels
eststo Model3

xtfeis v_wormi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun i.r_syear, cluster(pid) 
*******************
*FE with eco (HY3)*
*******************

xtreg v_wormi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun ib3.edu_level i.r_syear, fe cluster(pid) allbaselevels
eststo Model4

xtfeis v_wormi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun ib3.edu_level i.r_syear, cluster(pid)

esttab NullModel Model1 Model2 Model3 Model4 using results_new.rtf, replace se label


*************
*FE - WHOSMI*
*************

************
*Null Model*
************

xtreg v_whosmi i.r_syear, fe cluster(pid) allbaselevels
eststo NullModel

xtfeis v_whosmi i.r_syear, cluster(pid)
*********************
*FE with crime (HY1)*
*********************

xtreg v_whosmi i.v_wocri i.r_syear, fe cluster(pid) allbaselevels
eststo Model1

xtfeis v_whosmi i.v_wocri i.r_syear, cluster(pid)

*******************
*FE with eco (HY2)*
*******************

xtreg v_whosmi i.v_wocri i.v_woeco loghhincome i.r_syear, fe cluster(pid) allbaselevels
eststo Model2

xtfeis v_whosmi i.v_wocri i.v_woeco loghhincome i.r_syear, cluster(pid)

*******************
*FE with eco (HY2)*
*******************

xtreg v_whosmi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun i.r_syear, fe cluster(pid) allbaselevels
eststo Model3

xtfeis v_whosmi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun i.r_syear, cluster(pid)
*******************
*FE with eco (HY3)*
*******************

xtreg v_whosmi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun ib3.edu_level i.r_syear, fe cluster(pid) allbaselevels
eststo Model4

xtfeis v_whosmi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun ib3.edu_level i.r_syear, cluster(pid)

esttab NullModel Model1 Model2 Model3 Model4 using results_new.rtf, replace se label




