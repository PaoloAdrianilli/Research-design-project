global Wdata "/Users/andreazuliani/Desktop/New_research/Wdata"
use "$Wdata/recodata.dta", clear
label language EN
xtset pid syear

********************************************************
*DESCRITPIVE OF SAMPLE AFTER HAVING DEALT WITH MISSINGS*
********************************************************

tab syear
asdoc tab syear

*************************
*DESCRITPIVE OF HHINCOME*
*************************

*****************************************************
*Descriptives of the mean HHincome of the respondent*
*****************************************************

asdoc tabstat hhIncome, by(syear) stat(mean), replace

bysort syear: egen mean_hhIncome = mean(hhIncome)
twoway (line mean_hhIncome syear), ///
    ytitle("Level of Income") ///
    title("Mean Level of Income") ///
	xlabel(2012(1)2018)

graph bar (median) hhIncome, over(syear)
graph bar (median) hhIncome, over(syear) ///
    ytitle("Median Income") ///
    title("Median Income by Year")

********************
*DESCRITPIVE OF AGE*
********************

kdensity d11101, lcolor(blue) ///
    title("Kernel Density of Age")

rename d11101 age

ssc install asdoc
asdoc summarize age, save(table1.doc) replace
asdoc tabulate sex, append
asdoc tabulate cohort_group, append
asdoc tabulate edu_level, append
asdoc tabulate bothprntsgerman, append

************************
*DESCRIPTIVE OF WORRIES*
************************

foreach var in v_wormi v_whosmi v_wjose v_wocri v_woeco {
	bysort syear: egen mean_`var' = mean(`var')
}

twoway connected mean_v_wormi syear, name(g1, replace) ///
    title("Mean Concern about immigration to Germany") ///
    ytitle("Worries about immigration to Germany") ///
    xlabel(2012(1)2018)

twoway connected mean_v_wjose syear, name(g2, replace) ///
    title("Mean Concern about Job Security") ///
    ytitle("Worries about job security") ///
    xlabel(2012(1)2018)
	
twoway connected mean_v_whosmi syear, name(g3, replace) ///
    title("Mean Concern about Hostility towards Foreigners") ///
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

*****************************
*DESCRIPTIVE EDUCATION LEVEL*
*****************************

tab bex4cert
tab bex4cert, missing
drop if missing(bex4cert)
graph bar (count), over(bex4cert) ///
    bar(1, color(gs14)) ///
    blabel(bar) ///
    ytitle("Number of individuals") ///
    title("Highest Education Level Achieved")
	
******************
*DESCRIPTIVE SEX *
******************

tab sex
graph bar (count), over(sex) blabel(bar) ///
    ytitle("Number of individuals") ///
    title("Sex Distribution")

****************************
*DESCRIPTIVE PARENTS ORIGIN*
****************************

tab bothprntsgerman
asdoc tab bothprntsgerman

************
*TIME DUMMY*
************

tab syear time_dummy
asdoc tab syear time_dummy

save "$Wdata/recodata.dta", replace

