global Wdata "/Users/andreazuliani/Desktop/New_research/Wdata"
use "$Wdata/mergedataset.dta", clear
label language EN
*to tell at STATA that this is a panel dataset
xtset pid syear
drop if syear <2012
drop if syear >2018
*To check for duplicates
duplicates report pid 
*if you do not put syear STATA is going to found a lot of duplicates because the same pid is present in more than one wave
duplicates report pid syear
*check for unique identifiers
isid pid syear
*to describe the structure of the dataset
*xtdescribe

*recode of worried about migrants
foreach oldname in bcp12710 bdp13311 bep12309 bfp14610 bgp14810 bhp_186_11 bip_170_11 {
    local year = ///
		cond("`oldname'" == "bcp12710", 2012, ///
		cond("`oldname'" == "bdp13311", 2013, ///
		cond("`oldname'" == "bep12309", 2014, ///
		cond("`oldname'" == "bfp14610",  2015, ///
        cond("`oldname'" == "bgp14810",   2016, ///
		cond("`oldname'" == "bhp_186_11", 2017, ///
		cond("`oldname'" == "bip_170_11", 2018, .)))))))
        
    rename `oldname' wormi_`year'
}

gen wormi = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace wormi = wormi_`y' if syear == `y'
}
label var wormi "Worried about migrants"
tab syear wormi
drop wormi_2012 wormi_2013 wormi_2014 wormi_2015 wormi_2016 wormi_2017 wormi_2018

*recode of worried about hostility to foreigners| bhp_186_12 WORRIED ABOUT XENOPHOBIA?
foreach oldname in bcp12711 bdp13312 bep12310 bfp14611 bgp14811 bhp_186_12 bip_170_12 {
	local year = ///
		cond("`oldname'" == "bcp12711", 2012, ///
		cond("`oldname'" == "bdp13312", 2013, ///
		cond("`oldname'" == "bep12310", 2014, ///
		cond("`oldname'" == "bfp14611",  2015, ///
        cond("`oldname'" == "bgp14811",   2016, ///
		cond("`oldname'" == "bhp_186_12", 2017, ///
		cond("`oldname'" == "bip_170_12", 2018, .)))))))
        
    rename `oldname' whosmi_`year'
}

gen whosmi = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace whosmi = whosmi_`y' if syear == `y'
}
label var whosmi "Worried about hostility to foreigners"
tab syear whosmi
drop whosmi_2012 whosmi_2013 whosmi_2014 whosmi_2015 whosmi_2016 whosmi_2017 whosmi_2018

*recode of Worried About Job Security
foreach oldname in bcp12713 bdp13314 bep12311 bfp14612 bgp14812 bhp_186_13 bip_170_13 {
	local year = ///
		cond("`oldname'" == "bcp12713", 2012, ///
		cond("`oldname'" == "bdp13314", 2013, ///
		cond("`oldname'" == "bep12311", 2014, ///
		cond("`oldname'" == "bfp14612",  2015, ///
        cond("`oldname'" == "bgp14812",   2016, ///
		cond("`oldname'" == "bhp_186_13", 2017, ///
		cond("`oldname'" == "bip_170_13", 2018, .)))))))
	rename `oldname' wjose_`year'
}

gen wjose = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace wjose = wjose_`y' if syear == `y'
}
label var wjose "Worried about job security"
tab syear wjose
drop wjose_2012 wjose_2013 wjose_2014 wjose_2015 wjose_2016 wjose_2017 wjose_2018

*recode of worried about crime in Germany 
foreach oldname in bcp12709 bdp13310 bep12308 bfp14608 bgp14808 bhp_186_08 bip_170_08v2 {
	local year = ///
		cond("`oldname'" == "bcp12709", 2012, ///
		cond("`oldname'" == "bdp13310", 2013, ///
		cond("`oldname'" == "bep12308", 2014, ///
		cond("`oldname'" == "bfp14608",  2015, ///
        cond("`oldname'" == "bgp14808",   2016, ///
		cond("`oldname'" == "bhp_186_08", 2017, ///
		cond("`oldname'" == "bip_170_08v2", 2018, .)))))))	
	rename `oldname' wocri_`year'
}

gen wocri = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace wocri = wocri_`y' if syear == `y'
}
label var wocri "Worried about crime in Germany"
tab syear wocri
drop wocri_2012 wocri_2013 wocri_2014 wocri_2015 wocri_2016 wocri_2017 wocri_2018

*recode of worried about economic development
foreach oldname in bcp12701 bdp13301 bep12301 bfp14601 bgp14801 bhp_186_01 bip_170_01 {
	local year = ///
		cond("`oldname'" == "bcp12701", 2012, ///
		cond("`oldname'" == "bdp13301", 2013, ///
		cond("`oldname'" == "bep12301", 2014, ///
		cond("`oldname'" == "bfp14601", 2015, ///
		cond("`oldname'" == "bgp14801", 2016, ///
		cond("`oldname'" == "bhp_186_01", 2017, ///
		cond("`oldname'" == "bip_170_01", 2018, .)))))))
	rename `oldname' woeco_`year'
}

gen woeco = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace woeco = woeco_`y' if syear == `y'
}
label var woeco "Worried about economic development"
tab syear woeco
drop woeco_2012 woeco_2013 woeco_2014 woeco_2015 woeco_2016 woeco_2017 woeco_2018

label define worries 1 "Very concerned" 2 "Somewhat concerned" 3 "Not concerned at all" -5 "not included in this questionnaire" -1 "no answer" -2 "doesn't apply" -6 "version of the questionnaire with modified filtering"

foreach var in wormi woeco wocri wjose whosmi {
	label values `var' worries
}
*wjose STILL PROBLEMATIC

foreach var in wormi whosmi wjose wocri woeco {
    replace `var' = .a if `var' == -5
    replace `var' = .b if `var' == -2
    replace `var' = .c if `var' == -1
	replace `var' = .d if `var' == -6
}

tab wjose, m


foreach var in wormi whosmi wjose wocri woeco {
    vreverse `var', gen (v_`var')
}
xttab v_wjose
*************************************************************************************
*************************************************************************************
* recode of maternity and paternity leave
foreach oldname in bcp06 bdp13121212 bep07v2 bfp13v2 bgp11v2 bhp_12 bip_19v2 {
	local year = ///
		cond("`oldname'" == "bcp06", 2012, ///
		cond("`oldname'" == "bdp13121212", 2013, ///
		cond("`oldname'" == "bep07v2", 2014, ///
		cond("`oldname'" == "bfp13v2", 2015, ///
		cond("`oldname'" == "bgp11v2", 2016, ///
		cond("`oldname'" == "bhp_12", 2017, ///
		cond("`oldname'" == "bip_19v2", 2018, .)))))))
	rename `oldname' mapaleave_`year'
}

gen mapaleave = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace mapaleave = mapaleave_`y' if syear == `y'
}
label var mapaleave "maternity and paternity leave"
label define mothfathlv 1 "Yes, Maternity Leave" 2 "Yes, Paternity Leave" 3 "No" -1 "No answer" -5 "Not included in Questionnaire Version"
label values mapaleave mothfathlv
drop mapaleave_2012 mapaleave_2013 mapaleave_2014 mapaleave_2015 mapaleave_2016 mapaleave_2017 mapaleave_2018
tab mapaleave syear

* recode of Paid work in the last seven days 
foreach oldname in bcp05 bdp12v2 bep06v2 bfp12v2 bgp10v2 bhp_11v2 bip_18v2 {
	local year = ///
		cond("`oldname'" == "bcp05", 2012, ///
		cond("`oldname'" == "bdp12v2", 2013, ///
		cond("`oldname'" == "bep06v2", 2014, ///
		cond("`oldname'" == "bfp12v2", 2015, ///
		cond("`oldname'" == "bgp10v2", 2016, ///
		cond("`oldname'" == "bhp_11v2", 2017, ///
		cond("`oldname'" == "bip_18v2", 2018, .)))))))
	rename `oldname' paidworksvnd_`year'
}

gen paidworksvnd = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace paidworksvnd = paidworksvnd_`y' if syear == `y'
}

drop paidworksvnd_2012 paidworksvnd_2013 paidworksvnd_2014 paidworksvnd_2015 paidworksvnd_2016 paidworksvnd_2017 paidworksvnd_2018

tab syear paidworksvnd

label define paidwork 1 "Yes" 2 "No" -1 "No answer" -5 "Not included in this version of questionnaire"
label values paidworksvnd paidwork
tab paidworksvnd syear

* recode of Both Parents from Germany
foreach oldname in bcp142 bdp146 bep132 bfp161 bgpm_p_60 bhp_191 bip_60_q104 {
	local year = ///
		cond("`oldname'" == "bcp142", 2012, ///
		cond("`oldname'" == "bdp146", 2013, ///
		cond("`oldname'" == "bep132", 2014, ///
		cond("`oldname'" == "bfp161", 2015, ///
		cond("`oldname'" == "bgpm_p_60", 2016, ///
		cond("`oldname'" == "bhp_191", 2017, ///
		cond("`oldname'" == "bip_60_q104", 2018, .)))))))
	rename `oldname' bothprntsgerman_`year'
}

gen bothprntsgerman = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace bothprntsgerman = bothprntsgerman_`y' if syear == `y'
}

drop bothprntsgerman_2012 bothprntsgerman_2013 bothprntsgerman_2014 bothprntsgerman_2015 bothprntsgerman_2016 bothprntsgerman_2017 bothprntsgerman_2018

tab syear bothprntsgerman

label define parentsgerman 1 "Yes" 2 "No" -1 "No answer" -2 "Does not apply" -5 "Not included in this version of questionnaire"
label values bothprntsgerman parentsgerman
tab bothprntsgerman syear


*keep highest school leaving certificate ever obtained
tab syear bex4cert
label define educationlevel -2 "Does not apply" -1 "No Answer" 1 "Secondary School Degree" 2 "Intermediate School Degree" 3 "Technical School Degree" 4 "Upper Secondary Degree" 5 "Other Degree" 6 "No school degree (yet), dropout"
label values bex4cert educationlevel
label define educationlevel -2 "Does not apply" -1 "No Answer" 1 "Secondary School Degree" 2 "Intermediate School Degree" 3 "Technical School Degree" 4 "Upper Secondary Degree" 5 "Other Degree" 6 "No school degree (yet), dropout", modify
tab bex4cert syear if inrange(syear, 2012, 2018)


* recode of Year Of Birth
foreach oldname in bcp12803 bdp13403 bep12603 bfpbirthy bgpbirthy bhpbirthy bipbirthy {
	local year = ///
		cond("`oldname'" == "bcp12803", 2012, ///
		cond("`oldname'" == "bdp13403", 2013, ///
		cond("`oldname'" == "bep12603", 2014, ///
		cond("`oldname'" == "bfpbirthy", 2015, ///
		cond("`oldname'" == "bgpbirthy", 2016, ///
		cond("`oldname'" == "bhpbirthy", 2017, ///
		cond("`oldname'" == "bipbirthy", 2018, .)))))))
	rename `oldname' birthyr_`year'
}

gen birthyr = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace birthyr = birthyr_`y' if syear == `y'
}

drop birthyr_2012 birthyr_2013 birthyr_2014 birthyr_2015 birthyr_2016 birthyr_2017 birthyr_2018

tab birthyr syear if inrange(syear, 2012, 2018)

*time dummy through month of interview 
gen interview_date = ym(syear,imonth)
gen time_dummy = .
replace time_dummy = 0 if interview_date < ym(2015,7)
replace time_dummy = 1 if interview_date >= ym(2015,7)
drop if time_dummy == 1 & syear == 2012
drop if time_dummy == 1 & syear == 2013
drop if time_dummy == 1 & syear == 2014
replace time_dummy = . if syear == 2015 & imonth ==.
tab syear time_dummy, m

ssc install asdoc
asdoc tab syear time_dummy, replace 

*isco

foreach oldname in bdp38_isco08 bep28_isco08 bfp52_isco08 bgp48_isco08 bhp_52_isco08 bip_61_isco08 {
	local year = ///
		cond("`oldname'" == "bdp38_isco08", 2013, ///
		cond("`oldname'" == "bep28_isco08", 2014, ///
		cond("`oldname'" == "bfp52_isco08", 2015, ///
		cond("`oldname'" == "bgp48_isco08", 2016, ///
		cond("`oldname'" == "bhp_52_isco08", 2017, ///
		cond("`oldname'" == "bip_61_isco08", 2018, .))))))
	rename `oldname' isco_08_`year'
}

gen isco_08 = .
foreach y in 2013 2014 2015 2016 2017 2018 {
	replace isco_08 = isco_08_`y' if syear == `y'
}
tab isco_08
drop isco_08_2013 isco_08_2014 isco_08_2015 isco_08_2016 isco_08_2017 isco_08_2018

iscogen isei = isei(isco_08)

*********************
*BALANCING THE PANEL*
*********************


*********************************************************************************
*We want to deal with a balanced panel. So I'll keep only those people that have
*given an answer in all the following years:
********************************************************************************

keep if inrange(syear, 2012, 2018)

bysort pid: gen count_years = _N
keep if count_years == 7
tab syear 
asdoc tab syear

*I run the previous command for 14/16 =26k per year | 13/17 22k per year | 12/18 17k per year 

tab v_wormi, missing 

* Count nonmissing responses per person
gen yes_wormi = !missing(v_wormi)
bysort pid (syear): gen wormi_count = sum(yes_wormi)
bysort pid (syear): replace wormi_count = wormi_count[_N]

* we decided 5 because in that way we only drop 2 thousands people in totale (still 16,141 per year). If we do 6, we will get to 12,598 per year.

keep if wormi_count >= 5

tab wormi_count
tab v_wormi, missing

tab syear

***************************************************************************************
* PREPARATION FOR THE OTHER VARIABLES * I DID NOT RUN THIS: AS WE HAVE TO DECIDE STILL*
***************************************************************************************

**********
* WHOSMI *
**********

tab whosmi, missing 

* Count nonmissing responses per person
gen yes_whosmi = !missing(v_whosmi)
bysort pid (syear): gen whosmi_count = sum(yes_whosmi)
bysort pid (syear): replace whosmi_count = whosmi_count[_N]

keep if whosmi_count >= 5

tab whosmi_count
tab whosmi, missing



*********
* WOCRI *
*********

tab whosmi, missing 

* Count nonmissing responses per person
gen yes_wocri = !missing(v_wocri)
bysort pid (syear): gen wocri_count = sum(yes_wocri)
bysort pid (syear): replace wocri_count = wocri_count[_N]

keep if wocri_count >= 5

tab wocri_count
tab v_wocri, missing


*********
* WOECO *
*********

tab whosmi, missing 

* Count nonmissing responses per person
gen yes_woeco = !missing(v_woeco)
bysort pid (syear): gen woeco_count = sum(yes_woeco)
bysort pid (syear): replace woeco_count = woeco_count[_N]


keep if woeco_count >= 5

tab woeco_count
tab v_woeco, missing

tab syear


************
* HHINCOME *
************


* Count nonmissing responses per person
gen yes_hhincome = !missing(i11103)
bysort pid (syear): gen hhincome_count = sum(yes_hhincome)
bysort pid (syear): replace hhincome_count = hhincome_count[_N]


keep if hhincome_count >= 5

tab syear
asdoc tab syear

***********
*EDUCATION*
***********

tab pgisced11, missing 

gen edu_level = .
replace edu_level = 1 if inrange(pgisced11, 0, 2)
replace edu_level = 2 if inrange(pgisced11, 3, 4)
replace edu_level = 3 if inrange(pgisced11, 5, 8)

label define edulabel 1 "Low" 2 "Medium" 3 "High"
label values edu_level edulabel

ta edu_level


foreach var in v_wormi v_whosmi v_wocri v_woeco i11103 {
    
    // Step 1: Create year-specific mean for each variable
    bysort syear: egen mean_`var' = mean(`var')

    // Step 2: Replace missing values with year-specific mean
    replace `var' = mean_`var' if missing(`var')

    // (Optional) Drop the mean variable if you don't need it
    drop mean_`var'
}

tab syear v_wormi

**********
*PRE-TEST*
**********
****FIRST WAY OF CREATING TIME DUMMY
ssc install coefplot
tab syear
*gen three time dummies for pret-test (conceptuall -1. 0. 1)
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

********************
*Pre-test 2014-2016*
********************

regress v_wormi pre_event event post_event
estimates store model1

coefplot model1, keep(pre_event event_0 event_1 post_event) ///
    vertical ytitle("Coefficient") ///
    yline(0) ciopts(recast(rcap)) ///
    title("Effect of Event Timing on Outcome") ///
    note("Controls included: [list your controls]")

margins, at(pre_event=1 event=0 post_event=0) ///
         at(pre_event=0 event=1 post_event=0) ///
         at(pre_event=0 event=0 post_event=1) 

marginsplot, ///
     xlabel(1 "2014" 2 "2015" 3 "2016") ///
     title("Attitudes towards immigrants by Years") ///
     ytitle("Attitudes towards immigrants") ///
     name(margins_event, replace)

tab syear
	 
********************
*Pre-test 2013-2016*
********************

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
     title("Attitudes towards immigrants by Years") ///
     ytitle("Attitudes towards immigrants") ///
     name(margins_event, replace)

****************
*COUNTERFACTUAL*
****************
	 
display 1.83346-1.923935
*we are testing parallel trend assumption if the results is 0 it is respected. we have -.090475, so we can say it is maintainable. 

display 2.033657-2.329664
*We are computing the difference between the pre-event (2014) and the post-event (2016). The result is -.296007. However, this overstimates the actual difference between the pre-event and the post-event as it is not maintainable that the trend falltens. 
	 
display (2.033657+.0150572*3)- 2.329664
*Therefore, we computed the trend under the assumption of linear growth (beta2014*3) and we subtracted it to the observed trend. and the result is -.2508354.

display (2.033657+.0150572*3) 
*2.0788286

	 
		 

/*
misstable summarize i11103 v_wormi v_whosmi v_wjose v_woeco v_wocri
*I checked the n of missing for those variables and I decided to exlude v_wjose. 
*too many missing values
*I'll substitute the missing values with the variable mean
local vars v_wormi v_whosmi v_woeco v_wocri i11103

foreach var of local vars {
    egen mean_`var' = mean(`var')
    replace `var' = mean_`var' if `var' == .
    drop mean_`var'
}

summarize v_wormi v_whosmi i11103 v_woeco v_wocri
*/


********************
*RECODING BIRTHYEAR*
********************

tab birthyr
label define cohort_lbl ///
    1 "Born 1915–1945" ///
    2 "Born 1946–1960" ///
    3 "Born 1961–1975" ///
    4 "Born 1976–1996"
gen cohort_group = .
replace cohort_group = 1 if inrange(birthyr, 1915, 1945)
replace cohort_group = 2 if inrange(birthyr, 1946, 1960)
replace cohort_group = 3 if inrange(birthyr, 1961, 1975)
replace cohort_group = 4 if inrange(birthyr, 1976, 1996)
label values cohort_group cohort_lbl
ta cohort_group

***********************
*REGISTERED UNEMPLOYED*
***********************

foreach oldname in bcp08 bdp15 bep09 bfp15 bgp13 bhp_14 bip_21 {
	local year = ///
		cond("`oldname'" == "bcp08", 2012, ///
		cond("`oldname'" == "bdp15", 2013, ///
		cond("`oldname'" == "bep09", 2014, ///
		cond("`oldname'" == "bfp15",  2015, ///
        cond("`oldname'" == "bgp13",   2016, ///
		cond("`oldname'" == "bhp_14", 2017, ///
		cond("`oldname'" == "bip_21", 2018, .)))))))	
	rename `oldname' regun_`year'
}

gen regun = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace regun = regun_`y' if syear == `y'
}

label var regun "Registered unemployed"
tab syear regun
drop regun_2012 regun_2013 regun_2014 regun_2015 regun_2016 regun_2017 regun_2018
*/[1] Yes [2] No

*************************
*
*/Amount of support
ta bcp12602 syear
ta bdp13202 syear
ta bep12002 syear
ta bfp14502 syear
ta bgp146 syear
ta bhp_185 syear
ta bip_174 syear

foreach oldname in bcp12602 bdp13202 bep12002 bfp14502 bgp146 bhp_185 bip_174 {
	local year = ///
		cond("`oldname'" == "bcp12602", 2012, ///
		cond("`oldname'" == "bdp13202", 2013, ///
		cond("`oldname'" == "bep12002", 2014, ///
		cond("`oldname'" == "bfp14502",  2015, ///
        cond("`oldname'" == "bgp146",   2016, ///
		cond("`oldname'" == "bhp_185", 2017, ///
		cond("`oldname'" == "bip_174", 2018, .)))))))	
	rename `oldname' ppsupport_`year'
}

gen ppsupport = .
foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace ppsupport = ppsupport_`y' if syear == `y'
}

label var ppsupport "Amount of support to political party"
tab syear ppsupport
drop ppsupport_2012 ppsupport_2013 ppsupport_2014 ppsupport_2015 ppsupport_2016 ppsupport_2017 ppsupport_2018
describe ppsupport
label define pp_support 1 "Very Strong" 2 "Fairly Strong" 3 "Moderate" 4 "Fairly Weak" 5 "Very Weak"
label values ppsupport pp_support 


save "$Wdata/recodata", replace 
