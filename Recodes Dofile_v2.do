global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
use "$Wdata\mergedataset.dta", clear
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

save "$Wdata\recodata", replace 
