global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
use "$Wdata\mergeddataset.dta"
label language EN
*to tell at STATA that this is a panel dataset
xtset pid syear
*to check for duplicates
duplicates report pid
duplicates report pid syear
isid pid syear
*to describe the structure of the dataset
xtdescribe

*recode of worried about migrants
foreach oldname in bcp12710 bdp13310 bep12309 bfp14608 bgp14810 bhp_186_11 bip_170_11 {
    local year = ///
		cond("`oldname'" == "bcp12710", 2012, ///
		cond("`oldname'" == "bdp13310", 2013, ///
		cond("`oldname'" == "bep12309", 2014, ///
		cond("`oldname'" == "bfp14608",  2015, ///
        cond("`oldname'" == "bgp14810",   2016, ///
		cond("`oldname'" == "bhp_186_11", 2017, ///
		cond("`oldname'" == "bip_170_11", 2018, .)))))))
        
    rename `oldname' wormi_`year'
}

gen wormi = .

foreach y in 2012 2013 2014 2015 2016 2017 2018 {
	replace wormi = wormi_`y' if syear == `y'
}

tab syear wormi
drop wormi_2012 wormi_2013 wormi_2014 wormi_2015 wormi_2016 wormi_2017 wormi_2018

