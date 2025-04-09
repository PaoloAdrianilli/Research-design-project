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

tab syear whosmi
drop whosmi_2012 whosmi_2013 whosmi_2014 whosmi_2015 whosmi_2016 whosmi_2017 whosmi_2018
