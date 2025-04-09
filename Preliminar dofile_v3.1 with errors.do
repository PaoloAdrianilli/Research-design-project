*Research design
*Update on github following this rule: significant changes: new do_vn | minor changes overwrite the existent one
********************************************************************************

global mydir "C:\Users\utente\OneDrive\Desktop\Research Design"
cd "$mydir"

global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
global odata "C:\Users\utente\OneDrive\Desktop\Research Design\Odata"
global dofile "C:\Users\utente\OneDrive\Desktop\Research Design\Dofile"

*To check what's in the folder
dir
*SOEP companion
net install soephelp, replace from(https://git.soep.de/mpetrenz/soephelp)
*It doesn't work
********************************************************************************
*Merging the different SOEP waves

******************** Choosing the variables
*2011
use "$Wdata\bbp.dta", clear 
label language EN
keep bbp13101 /// Worried About Economic Development
bbp8401 /// General-Education School Degree
bbp13113 /// Worried About Job Security
bbp13109 /// worried about crime in germany
bbp13111 /// Worried About Hostility To Foreigners
bbp13101 /// Worried About Economic Development
bbp04 /// Paid Work In Last 7 Days
bbp0501 /// Maternity, Paternity Leave
bbp135 /// Mother Tongue German: Both Parents > NEED TO CHECK  
bbp13201 /// sex
bbp13202 /// Year of birth
bbp28_isco88 /// Current occupation (ISCO-88 COM)
bbp0501 /// Maternity, Paternity Leave
bbp9109 /// Maternity Leave Jan-Dec Prev. Yr
pid /// Never Changing Person ID
syear /// survey year
cid //
save "$Wdata\bbp.dta", replace

*2012
use "$Wdata\bcp.dta", clear 
label language EN

keep bcp12701 /// Worried About Economic Development
bcp12708 /// Worried About global terrorism
bcp12709 /// worried about crime in germany
bcp12710 /// Worried About Immigration To Germany
bcp12711 /// Worried About Hostility To Foreigners
bcp12713 /// Worried About Job Security
bcp7201 /// General-Education School Degree
bcp12803 /// Year Of Birth
bcp12801 /// Sex
bcp142 /// Both Parents Born In Germany
bcp28_isco88 /// Current occupation (ISCO-88 COM)
pid /// Never Changing Person ID
syear /// Survey Year
cid //
save "$Wdata\bcp.dta", replace

*2013 
use "$Wdata\bdp.dta", clear
label language EN
*I genereate some variables that aren't usable otherwise
gen bdp12v2 = bdp12
label def yesno 1 "yes" 2 "no" 
label values bdp12v2 yesno
label variable bdp12v2 "Paid Work in the last 7 days"
gen bdp13121212 = bdp13
label def palv -1 "no answer" 1 "yes, maternity leave" 2 "yes, parental leave" 3 "no"
label values bdp13121212 palv
label variable bdp13121212 "maternity, paternity leave"

keep bdp13311 bdp9001 bdp13314 bdp13310 bdp13301 bdp13401 bdp38_isco88 syear bdp13121212 bdp13403 pid bdp13312 bdp13309 bdp12v2 bdp146 cid

*keep bdp13311 /// Worried About Immigration To Germany
bdp9001 /// General-Education School Degree
bdp13314 /// Worried About Job Security
bdp13310 /// worried about crime in germany
bdp13312 /// Worried About Hostility To Foreigners
bdp13301 /// Worried About Economic Development
bdp13309 /// Worried About global terrorism
bdp12v2 /// Paid Work in the last 7 days
*bdp13401 /// Gender
bdp146 /// Both Parents Born In Germany
bdp38_isco88 /// Current occupation (ISCO-88 COM)
pid /// Never Changing Person ID
syear // Survey Year
* bdp13121212 /// maternity, paternity leave !!! still not working
*bdp13403 /// Year Of Birth 

save "$Wdata\bdp.dta", replace

*2014
use "$Wdata\bep.dta", clear
label language EN
gen bep06v2 = bep06 
label values bep06v2 yesno
label variable bep06v2 "Paid Work in the last 7 days"
gen bep07v2 = bep07
label values bep07v2 palv
label variable bep07v2 "maternity, paternity leave"


keep bep12301 /// Worried About Economic Development
bep12308 /// worried about crime in germany
bep12309 /// Worried About Immigration To Germany
bep12310 /// Worried About Hostility To Foreigners
bep12311 /// Worried About Job Security
bep6902 /// General-Education School Degree
bep07v2 ///
bep06v2 ///
bep12603 /// Year Of Birth
bep12601 /// Gender
bep132 /// Both Parents Born In Germany
bep28_isco88 /// Current occupation (ISCO-88 COM)
pid /// Never Changing Person ID
syear /// Survey Year
cid //

save "$Wdata\bep.dta", replace

*2015
use "$Wdata\bfp.dta", clear 
label language EN
gen bfp12v2 = bfp12 
label values bfp12v2 yesno
label variable bfp12v2 "Paid Work in the last 7 days"
gen bfp13v2 = bfp13
label values bfp13v2 palv
label variable bfp13v2 "maternity, paternity leave"
gen bfp2102v2 = bfp2102 
lab var bfp2102v2 "General-Education School Degree"
lab def genedu -5 "not included in this version of the questionnaire" ///
-2 "does not apply" -1 "no answer" 1 "secondary school degree" 2 "intermediate school degree" 3 "technical school degree" 4 "upper secondary degree" 5 "other degree"
lab values bfp2102v2 genedu

keep bfp14601 /// Worried About Economic Development
bfp14608 /// worried about crime in germany
bfp14610 /// Worried About Immigration To Germany
bfp12v2 ///
bfp13v2 ///
bfp2102v2 ///
bfp14611 /// Worried About Hostility To Foreigners
bfp14612 /// Worried About Job Security
bfp52_isco88 /// Current occupation (ISCO-88 COM)
syear /// Survey Year
pid /// Never Changing Person ID
cid //

save "$Wdata\bfp.dta", replace

*2016
use "$Wdata\bgp.dta", clear
label language EN

gen bgp10v2 = bgp10
label values bgp10v2 yesno
label variable bgp10v2 "Paid Work in the last 7 days"
gen bgp11v2 = bgp11
label values bgp11v2 palv
label variable bgp11v2 "maternity, paternity leave"
gen bgp2102v2 = bgp2102 
lab var bgp2102v2 "General-Education School Degree"
lab values bgp2102v2 genedu

keep bgp14801 /// Worried About Economic Development
bgp14808 /// worried about crime in germany
bgp14810 /// Worried About Immigration To Germany
bgp10v2 ///
bgp11v2 ///
bgp14811 /// Worried About Hostility To Foreigners
bgp14812 /// Worried About Job Security
bgp2102v2 ///
bgp2107_isco88 /// Vocation (ISCO-88 COM)
syear /// Survey Year
pid /// Never Changing Person ID
cid //

save "$Wdata\bgp.dta", replace

*2017
use "$Wdata\bhp.dta", clear
label language EN
gen bhp_11v2 = bhp_11
label values bhp_11v2 yesno
label variable bhp_11v2 "Paid Work in the last 7 days"
*gen bhp_122_08v2 = bhp_122_08
*label values bhp_122_08v2 palv
*label variable bhp_122_08v2 "maternity, paternity leave"

keep bhp_186_01 /// Worried About Economic Development
bhp_186_11 /// Worried About Immigration to Germany
bhp_11v2 ///
bhp_186_13 /// Worried About Job Security
bhp_186_08 /// Worried About Crime
bhp_186_12 /// Worried Xenophobia in Germany
bhp_22_02 /// General-Education School Degree
bhp_52_isco88 /// Current occupation (ISCO-88 COM)
syear /// Survey Year
pid /// Never Changing Person ID
cid //
*bhp_122_08v2
save "$Wdata\bhp.dta", replace

*2018
use "$Wdata\bip.dta", clear
label language EN
gen bip_18v2 = bip_18
label values bip_18v2 yesno
label variable bip_18v2 "Paid Work in the last 7 days"
gen bip_19v2 = bip_19
label values bip_19v2 palv
label variable bip_19v2 "maternity, paternity leave"
gen bip_170_08v2 = bip_170_08
label variable bip_170_08v2 "concern crime in Germany"
lab def crg -5 "not included in this version of the questionnaire" ///
 -1 "no answer" 1 "very concern" 2 "some worries" 3 "no worries"
lab values bip_170_08v2 crg

keep bip_170_01 /// Worried About Economic Development
bip_170_11 /// Worried About Immigration to Germany
bip_170_13 /// Worried About Job Security
bip_18v2 ///
bip_19v2 ///
bip_170_08v2 ///
bip_29_02 /// General-Education School Degree
bip_170_12 /// Concern hostility towards foreigners or minorities in Germany
bip_61_isco08 /// Current occupation (ISCO-08)
syear /// Survey Year
pid /// Never Changing Person ID
cid //
save "$Wdata\bip.dta", replace

*2019
use "$Wdata\bjp.dta", clear

keep bjp_174_12 bjp_174_08 bjp_174_11 bjp_174_13 bjp_174_01 bjp_07 bjp_46_isco08 pid bjp_12_02 bjp_08 cid
/*keep bjp_174_12 ///
bjp_174_08 ///
bjp_174_11 ///
bjp_174_13 ///
bjp_174_01 /// 
bjp_07 ///
bjp_46_isco08 ///
syear ///
pid //
bjp_12_02 /// (missing)
bjp_08 */
save "$Wdata\bjp.dta", replace

*End of waves
*Dataset with jobs/// biojob
use "$Wdata\biojob.dta", clear
keep cid ///
pid ///
nojob ///
isco08 ///
isei08 ///
stba10 ///
siops08 ///
egp08 ///
mps08 ///
yearlast ///
cid //
save "$Wdata\biojob.dta", replace

/*Dataset with info on parents /// bioparen*/
use "$Wdata\bioparen.dta", clear
keep pid ///
cid ///
fnr ///
mnr ///
fsedu ///
msedu ///
fisei08 ///
misei08 ///
fmps08 ///
mmps08 ///
fsiops08 ///
msiops08 ///
fegp08 ///
fisco08 ///
megp08 ///
misco08 ///
cid //
*megp08 /// (missing)
*misco08 ///
*this two variables contains mostly missing. I'm not sure if it is the case to add em
save "$Wdata\bioparen.dta", replace

/*Dataset with regional info /// regionl*/
use "$Wdata\regionl.dta", clear
keep cid ///
hid ///
syear ///
nuts1_c ///
nuts1_n ///
kr_uemprate ///
kr_foreigner ///
kr_emprate ///
kr_popdens ///
kr_population //
save "$Wdata\regionl.dta", replace
*kr_area /// (missing)

/*Dataset with edu info*/
use "$Wdata\bioedu.dta", clear
gen bex4certv2 = bex4cert
label var bex4certv2"highest school leaving certificate ever obtained"
lab def hedu -2 "does not apply" -1 "no answer" 1 "secondary school degree" 2 "intermediate school degree" 3 "technical school degree" 4 "upper secondary degree" 5 "other school degree" 6 "no school degree (yet), dropout"
label values bex4certv2 hedu

keep cid ///
pid ///
bex4cert ///
bex4cert2 //

save "$Wdata\bioedu.dta", replace
*********************************************************************
*Merge

/*To merge we need to open a "Master" dataset. According to what I read in the SOEP website 
(https://companion.soep.de/Working%20with%20SOEP%20Data/How%20to%20Merge%20SOEP%20Data.html), and in the
SOEPtutorials: Data Structure and Naming Conventions, yt video
 we should choose PPATHL. */ 

use "$Wdata\ppathl.dta", clear

*The command to merge consists in 4 parts:
*1 specify the kind of merge we want (e.g. 1:1)
*2 what are the key variables (identifiers)
*3 what dataset we want to add to the master
*4 (optional) which variables we want to take from the new dataset

merge 1:1 pid syear using "$Wdata\bbp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata\bcp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata\bdp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata\bep.dta"
drop _merge
merge 1:1 pid syear using "$Wdata\bfp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata\bgp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata\bhp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata\bip.dta"
drop _merge
merge m:1 pid cid using "$Wdata\biojob.dta" 
drop _merge
merge m:1 pid cid using "$Wdata\bioparen.dta"
drop _merge
merge m:1 pid cid using "$Wdata\bioedu.dta"
drop _merge
/*
The following ones are still not merged properly, I dunnow why
merge m:1 syear cid using "$Wdata\regionl.dta"
drop _merge
*/

*2019 not merged
*merge 1:1 pid syear using "$Wdata\bjp.dta" /// 2019
drop _merge
*I saw from many sources that as key variables we should use both pid and syear (survey year). 
*However in PPATHL the variable doesn't exists. What about the other ones?

save "$Wdata\mergeddataset", replace

*we are trying to append the dataset regionl as it does not have a pid so we are thinking that 
we need to append, because we are adding observations.

use "$Wdata\mergeddataset", clear
append using "$Wdata/regionl.dta"
save "$Wdata\mergeddataset", replace
