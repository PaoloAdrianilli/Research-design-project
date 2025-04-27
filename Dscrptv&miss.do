global Wdata "/Users/andreazuliani/Desktop/ResearchDesign/Wdata"
use "$Wdata/recodata.dta", clear
label language EN
xtset pid syear

*random descriptives of HHincome of the respondent
xtsum i11103
bysort syear: sum i11103
tabstat i11103, by(syear) stat(mean)

/*be careful to run the entire command at once (from preserve to restore). 
It produces the same result as the next command but it is quicker*/
********************************************************************************
preserve
collapse (mean) i11103_mean=i11103, by(syear)
line i11103_mean syear, sort
restore

*
preserve
collapse (mean) v_wormi_mean=v_wormi, by(syear)
line v_wormi_mean syear, sort
restore
***************************
bysort syear: egen mean_i11103 = mean(i11103)
twoway connected mean_i11103 syear
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

twoway connected mean_v_wjose syear, name(g2, replace) ///
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

graph combine g1 g2 g3 g4 g5, cols(2) title("Means by year")
*wocri, wormi, whosmi have a similiar pattern, woeco and wojose are basically still
*********************************************************************************
graph bar (median) i11103, over(syear)
graph bar (median) i11103, over(syear) ///
    ytitle("Median Income") ///
    title("Median Income by Year")

*********************************************************************************
*missing


misstable summarize v_wormi
*222,881 missings. 169,143 non missing.
tabulate syear v_wormi, missing row
/*% of miss changes a lot over the years. MCRA(missing completely at random) should
be excluded. Perhaps missings are MAR*/
egen nmiss = rowmiss(v_wormi)
bysort pid: egen total_miss = total(nmiss)
xttab total_miss
*
bysort pid: egen nonmiss_count = total(!mi(v_wormi))
gen good_coverage = (nonmiss_count >= 3)
xttab good_coverage
br nonmiss_count good_coverage
*
gen gc_wormi = v_wormi
replace gc_wormi =. if good_coverage ==0
*N.B These commands do not take into consideration if obs are prior or post 2015!!!!
graph bar (mean) nmiss, over(syear)

**********************************************************************************
* DEALING WITH MISSINGS FOR TIME-CONSTANT VARIABLES *


*******
* SEX *
*******

tab sex, mi
bys pid: egen misex = total(mi(sex))
tab misex

list pid year sex misex if misex>0, sepby(pid)

* For time-constant variables we can simply carryforward/backward 
*	non-missing information
ssc describe carryforward
ssc install carryforward

* Carry forward
bys pid (year): carryforward sex, replace
list pid year sex if misex>0, sepby(pid)

* Carry backward
gsort pid -year
by pid: carryforward sex, replace

list pid year sex if misex>0, sepby(pid)
tab sex, mi

* Drop if race unknown
drop if sex==.
drop misex


************************
* PARENTS FROM GERMANY *
************************

tab bothprntsgerman, mi
bys pid: egen misprnts = total(mi(bothprntsgerman))
tab misprnts

list pid year bothprntsgerman misprnts if misprnts>0, sepby(pid)

* For time-constant variables we can simply carryforward/backward 
*	non-missing information
ssc describe carryforward
ssc install carryforward

* Carry forward
bys pid (year): carryforward bothprntsgerman, replace
list pid year bothprntsgerman if misprnts>0, sepby(pid)

* Carry backward
gsort pid -year
by pid: carryforward bothprntsgerman, replace

list pid year bothprntsgerman if misprnts>0, sepby(pid)
tab bothprntsgerman, mi

* Drop if race unknown
drop if bothprntsgerman==.
drop misprnts

*****************
* YEAR OF BIRTH *
*****************

tab birthyr, mi
bys pid: egen misbirth = total(mi(birthyr))
tab misbirth

list pid year birthyr misbirth if misbirth>0, sepby(pid)

* For time-constant variables we can simply carryforward/backward 
*	non-missing information
ssc describe carryforward
ssc install carryforward

* Carry forward
bys pid (year): carryforward birthyr, replace
list pid year birthyr if misbirth>0, sepby(pid)

* Carry backward
gsort pid -year
by pid: carryforward birthyr, replace

list pid year birthyr if misbirth>0, sepby(pid)
tab birthyr, mi

* Drop if race unknown
drop if birthyr==.
drop misbirth
























