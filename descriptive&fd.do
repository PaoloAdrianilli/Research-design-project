global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
use "$Wdata/recodata.dta", clear
label language EN
xtset pid syear

********************************************************************************
* DESCRITPIVE OF SAMPLE AFTER HAVING DEALT WITH MISSINGS

tab syear
asdoc tab syear

********************************************************************************
* DESCRITPIVE OF HHINCOME

*random descriptives of the mean HHincome of the respondent
xtsum i11103
bysort syear: sum i11103
tabstat i11103, by(syear) stat(mean)
rename i11103 hhIncome
asdoc tabstat hhIncome, by(syear) stat(mean), replace

bysort syear: egen mean_hhIncome = mean(hhIncome)
twoway (line mean_hhIncome syear), ///
    ytitle("Level of Income") ///
    title("Mean Level of Income") ///
	xlabel(2012(1)2018)

*random descriptives of the median HHincome of the respondent
graph bar (median) hhIncome, over(syear)
graph bar (median) hhIncome, over(syear) ///
    ytitle("Median Income") ///
    title("Median Income by Year")

/*we made Income a logarithm // those who had income 0 were substituted with 
missings*/
gen loghhincome = log(hhIncome)

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
    ytitle("Worries about migrants") ///
    xlabel(2012(1)2018)

*/twoway connected mean_v_wjose syear, name(g2, replace) ///
    title("Mean Concern about Job Security") ///
    ytitle("Worries about job security") ///
    xlabel(2012(1)2018)
	
twoway connected mean_v_whosmi syear, name(g3, replace) ///
    title("Mean Concern about Hostility to Foreigners") ///
    ytitle("Worries about hostility to foreigners") ///
    xlabel(2012(1)2018)

twoway connected mean_v_wocri syear, name(g4, replace) ///
    title("Mean Concern about Crime") ///
    ytitle("Worries about crime") ///
    xlabel(2012(1)2018)
	
twoway connected mean_v_woeco syear, name(g5, replace) ///
    title("Mean Concern about Economic Development") ///
    ytitle("Worries about Economic Development") ///
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


*********************************************************************************
*First Difference models
xtset pid syear
/*
foreach var in v_wormi v_whosmi v_wocri v_woeco loghhincome hhIncome {
    gen d_`var' = D.`var'
}
*/
ssc install outreg2
*********
*TRIALS*
*********
*
*Fd 
*
xtreg v_wormi i.time_dummy, fe cluster(pid)
xtreg v_wormi i.syear, fe cluster(pid)


xtreg v_whosmi i.time_dummy, fe cluster(pid)
xtreg v_whosmi i.syear, fe cluster(pid)
*
*Fd with crime (hy1)
*
xtreg v_wormi v_wocri i.time_dummy, fe cluster(pid)
xtreg v_wormi v_wocri i.syear, fe cluster(pid)

*Fd with crime (hy1a)
xtreg v_whosmi v_wocri i.time_dummy, fe cluster(pid)
xtreg v_whosmi v_wocri i.syear, fe cluster(pid)
*
*Fd with crime and 2015 RECODED
*
gen r_syear = syear 
replace r_syear = 20155 if syear == 2015 & imonth <= 5
replace r_syear = 20156 if syear == 2015 & imonth >= 6

*Fd with crime (hy1)
xtreg v_wormi v_wocri i.r_syear, fe cluster(pid)
*Fd with crime (hy1a)
xtreg v_whosmi v_wocri i.r_syear, fe cluster(pid)

*Fd with crime, 2015 recoded and WOECO

xtreg v_wormi v_wocri v_woeco i.r_syear, fe cluster(pid)

xtreg v_whosmi v_wocri v_woeco i.r_syear, fe cluster(pid)
*
*Fd with crime, 2015 recoded, woeco and INCOME
*
xtreg v_wormi v_wocri v_woeco i.r_syear hhIncome, fe cluster(pid)
*income is usefull. h2 seems to hold

xtreg v_whosmi v_wocri v_woeco i.r_syear hhIncome, fe cluster(pid)
*income is useless. we didn't hypotesise hy2b and we were correct

*
* Fd with crime, 2015 recoded, woeco and EMPLOYMENT STATUS
*
xtreg v_wormi v_wocri v_woeco i.r_syear i.emplstus, fe cluster(pid)

xtreg v_whosmi v_wocri v_woeco i.r_syear i.emplstus, fe cluster(pid)
*employment status doesn't work well. However its missings are still not recoded as means
*and values 6,7,8 have very few obs, so it could be the case of recoding them


xtreg v_wormi v_wocri v_woeco i.r_syear i.regun , fe cluster(pid)

xtreg v_whosmi v_wocri v_woeco i.r_syear i.regun , fe cluster(pid)
* regun is't working particulary well


*
* Fd with crime, 2015 recoded, woeco, income and EDULEVEL	
*
xtreg v_wormi v_wocri v_woeco i.r_syear ib3.edu_level c.hhIncome, fe cluster(pid)
xtreg v_whosmi v_wocri v_woeco i.r_syear ib3.edu_level c.hhIncome, fe cluster(pid)

*FULL MODEL
xtreg v_wormi v_wocri v_woeco i.r_syear ib3.edu_level i.emplstus i.regun hhIncome, fe cluster(pid)

xtreg v_whosmi v_wocri v_woeco i.r_syear ib3.edu_level i.emplstus i.regun hhIncome, fe cluster(pid)


********************************************************************************
*STRATIFIED REG
****************





xtreg v_wormi i.time_dummy, fe
outreg2 using results.doc, replace se ctitle("Model 1")

xtreg d_v_wormi time_dummy d_loghhincome
outreg2 using results.doc, append se ctitle("Model 2")

xtreg d_v_wormi time_dummy d_loghhincome d_v_woeco 
outreg2 using results.doc, append se ctitle("Model 3")
xtset pid syear

xtreg v_wormi time_dummy loghhincome v_woeco v_wocri sex,fe
outreg2 using results.doc, append se ctitle("Model 4")

pwd

tab syear time_dummy

* GRAPH *
xtreg d_v_wormi time_dummy d_loghhincome d_v_woeco d_v_wocri


* Collapse to get the mean first difference per year
preserve
collapse (mean) v_wormi, by(syear)

* Line plot of average change by year
twoway (line v_wormi syear, sort lwidth(medthick) lcolor(navy)), ///
       title("Average First Difference of Worries about immigrants by Year") ///
	   xlabel(2012(1)2018) ///
       ytitle("Δ Worries about Immigrants") xtitle("Survey Year") ///
       legend(off)

restore

xtreg d_v_whosmi time_dummy 
outreg2 using results.doc, replace se ctitle("Model 1")

xtreg d_v_whosmi time_dummy d_loghhincome
outreg2 using results.doc, append se ctitle("Model 2")

xtreg d_v_whosmi time_dummy d_loghhincome d_v_woeco 
outreg2 using results.doc, append se ctitle("Model 3")

xtreg d_v_whosmi time_dummy d_loghhincome d_v_woeco d_v_wocri 
outreg2 using results.doc, append se ctitle("Model 4")

pwd

* GRAPH *
xtreg d_v_whosmi time_dummy d_loghhincome d_v_woeco d_v_wocri 

preserve

* Collapse to get the mean first difference per year
collapse (mean) d_v_whosmi, by(syear)

* Line plot of average change by year
twoway (line d_v_whosmi syear, sort lwidth(medthick) lcolor(navy)), ///
       title("Average First Difference of Worries about Xenophobia") ///
	   xlabel(2012(1)2018) ///
       ytitle("Δ Worries about Xenophobia") xtitle("Survey Year") ///
       legend(off)

restore




/*
/*be careful to run the entire command at once (from preserve to restore). 
It produces the same result as the next command but it is quicker*/
********************************************************************************
preserve
collapse (mean) hhIncome_mean=hhIncome, by(syear)
line hhIncome_mean syear, sort
restore

*
preserve
collapse (mean) v_wormi_mean=v_wormi, by(syear)
line v_wormi_mean syear, sort
restore
*/
***************************




