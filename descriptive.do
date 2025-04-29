global Wdata "/Users/andreazuliani/Desktop/New_research/Wdata"
use "$Wdata/recodata.dta", clear
label language EN
xtset pid syear

*random descriptives of HHincome of the respondent
xtsum i11103
bysort syear: sum i11103
tabstat i11103, by(syear) stat(mean)
rename i11103 hhIncome
asdoc tabstat hhIncome, by(syear) stat(mean), replace

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
***************************
bysort syear: egen mean_hhIncome = mean(hhIncome)
twoway (line mean_hhIncome syear), ///
    ytitle("Level of Income") ///
    title("Mean Level of Income") ///
	xlabel(2012(1)2018)

********************************************************************************
* Two ways of plotting the same thing (I prefer the second one).   | WORRIES |
********************************************************************************
graph bar (mean) v_wormi, over(syear) name(g1, replace)
graph bar (mean) v_wjose, over(syear) name(g2, replace)
graph bar (mean) v_whosmi, over(syear) name(g3, replace)
graph bar (mean) v_woeco, over(syear) name(g4, replace)
graph bar (mean) v_wocri, over(syear) name(g5, replace)

graph combine g1 g2 g3 g4 g5, cols(2) title("Means by year")

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
*wocri, wormi, whosmi have a similiar pattern, woeco and wojose are basically still
*********************************************************************************
graph bar (median) hhIncome, over(syear)
graph bar (median) hhIncome, over(syear) ///
    ytitle("Median Income") ///
    title("Median Income by Year")

**********************************************************************************
* DESCRIPTIVE EDUCATION LEVEL *
tab bex4cert
tab bex4cert, missing
drop if missing(bex4cert)
graph bar (count), over(bex4cert) ///
    bar(1, color(gs14)) ///
    blabel(bar) ///
    ytitle("Number of individuals") ///
    title("Highest Education Level Achieved")
	
**********************************************************************************
* DESCRIPTIVE SEX 
tab sex
graph bar (count), over(sex) blabel(bar) ///
    ytitle("Number of individuals") ///
    title("Sex Distribution")

**********************************************************************************
* DESCRIPTIVE AGE 
kdensity d11101, lcolor(blue) ///
    title("Kernel Density of Age")

rename d11101 age

ssc install asdoc
asdoc summarize age, save(table1.doc) replace
asdoc tabulate sex, append
asdoc tabulate bex4cert, append
		

**********************************************************************************
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
ssc describe carryforward
ssc install carryforward

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
ssc describe carryforward
ssc install carryforward

* Carry forward
bys pid (syear): carryforward birthyr, replace
list pid syear birthyr if misbirth>0, sepby(pid)

* Carry backward
gsort pid -syear
by pid: carryforward birthyr, replace

list pid syear birthyr if misbirth>0, sepby(pid)
tab birthyr, mi

* Drop if race unknown
drop if birthyr==.
drop misbirth





*********************************************************************************
*First Difference model

* Generate first differences for all your variables of interest
foreach var in v_wormi v_whosmi v_wjose v_woeco v_wocri {
    gen diff_`var' = .  // Initialize first difference variables
    
    * Calculate first differences across years
    foreach y of numlist 2013/2018 {
        local prev = `y' - 1
        replace diff_`var' = `var'_`y' - `var'_`prev' if !missing(`var'_`y') & !missing(`var'_`prev')
    }
}

xtreg v_wormi birthyr, fe

preserve
drop if v_wormi == . 
xttab v_wormi
restore








