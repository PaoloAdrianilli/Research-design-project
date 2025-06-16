*Research design
*Update on github following this rule: significant changes: new do_vn | instead for minor changes overwrite the existent one
********************************************************************************
clear 
global mydir "/Users/andreazuliani/Desktop/New_research"
cd "$mydir"

global Wdata "/Users/andreazuliani/Desktop/New_research/Wdata"
global odata "/Users/andreazuliani/Desktop/New_research/Odata"
global dofile "/Users/andreazuliani/Desktop/New_research/Dofile"

*to check files into the directory
dir

*********
*DATASET*
*********

/*
The dataset which this research employs is derived from the German Socio-Economic Panel (SOEP), in particular SOEP CORE, 
which collects information of a variety of topics, such as demographic and family structure, migration and integration- 
related topics, political attitudes and social participation.
*/

**********************************
*Merging the different SOEP waves*
**********************************
*We decided, in order to have a cleaner dataset, to keep only the variables that we think we will use in the analysis.
*2012
use "$Wdata/bcp.dta", clear 
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
bcp05 /// Paid work in the last seven days 
pid /// Never Changing Person ID
syear /// Survey Year
bcp06 /// maternity and paternity leave 
bcp0103 /// Satisfaction with work
bcp0106 /// Satisfaction with personal income 
bcp11 /// Employment Status
bcp2202 /// Number of job changes 
bcp08 /// Registered Unemployed
bcp12601 /// Political party supported
bcp12602 /// Amount of Support for Political Party 
cid //
save "$Wdata/bcp.dta", replace

*2013 
use "$Wdata/bdp.dta", clear
label language EN
*I genereate some variables that aren't usable otherwise
gen bdp12v2 = bdp12
label def yesno 1 "yes" 2 "no" 
label values bdp12v2 yesno
label variable bdp12v2 "Paid Work in the last 7 da
gen bdp13121212 = bdp13
label def palv -1 "no answer" 1 "yes, maternity leave" 2 "yes, parental leave" 3 "no"
label values bdp13121212 palv
label variable bdp13121212 "maternity, paternity leave"

keep bdp13311 bdp9001 bdp13314 bdp13310 bdp13301 bdp13401 bdp38_isco08 syear bdp13121212 bdp13403 pid bdp13312 bdp13309 bdp12v2 bdp146 cid bdp0103 /// Satisfaction with work
bdp0106 /// Satisfaction with personal income 
bdp18 /// Employment Status
bdp3202 /// number of job changes 
bdp15 /// Registered Unemployed
bdp13201 /// Political party supported
bdp13202 // Amount of Support for Political Party

save "$Wdata/bdp.dta", replace


*2014
use "$Wdata/bep.dta", clear
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
bep07v2 /// Maternity and Paternity leave 
bep06v2 /// Paid work in the last seven days 
bep12603 /// Year Of Birth
bep12601 /// Gender
bep132 /// Both Parents Born In Germany
bep28_isco08 /// Current occupation (ISCO-08 COM)
pid /// Never Changing Person ID
syear /// Survey Year
bep0103 /// Satisfaction with work
bep0106 /// Satisfaction with personal income 
bep12 /// Employment Status
bep2202 /// number of job changes 
bep09 /// Registered Unemployed
bep12001 /// Political party supported
bep12002 /// Amount of Support for Political Party
cid //

save "$Wdata/bep.dta", replace

*2015
use "$Wdata/bfp.dta", clear 
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
bfp12v2 /// Paid work in the last seven days 
bfp13v2 /// Maternity and paternity leave 
bfp161 /// Both Parents Born In Germany
bfp2102v2 /// General-Education
bfp14611 /// Worried About Hostility To Foreigners
bfp14612 /// Worried About Job Security
bfp52_isco08 /// Current occupation (ISCO-08 COM)
syear /// Survey Year
pid /// Never Changing Person ID
bfpbirthy /// Year Of Birth
bfp0103 /// Satisfaction with work
bfp0106 /// Satisfaction with personal income 
bfp32 /// Employment Status
bfp4402 /// number of job changes 
bfp15 /// Registered Unemployed
bfp14501 /// Political party supported
bfp14502 /// Amount of Support for Political Party
cid //

save "$Wdata/bfp.dta", replace

*2016
use "$Wdata/bgp.dta", clear
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
bgp10v2 /// Paid work in the last seven days 
bgp11v2 /// Maternity and Paternity leave 
bgp14811 /// Worried About Hostility To Foreigners
bgp14812 /// Worried About Job Security
bgp2102v2 /// General-Education
bgpm_p_60 ///Both Parents Born In Germany
bgp48_isco08 /// Current occupation (ISCO-08 COM)
syear /// Survey Year
pid /// Never Changing Person ID
bgpbirthy /// Year Of Birth
cid ///
bgp146 bgp14501 bgp144 bgp0103 bgp0106 bgp13 bgp31 bgp4102

save "$Wdata/bgp.dta", replace

*2017
use "$Wdata/bhp.dta", clear
label language EN
gen bhp_11v2 = bhp_11
label values bhp_11v2 yesno
label variable bhp_11v2 "Paid Work in the last 7 days"


keep bhp_186_01 /// Worried About Economic Development
bhp_186_11 /// Worried About Immigration to Germany
bhp_11v2 /// Paid work in the last seven days 
bhp_186_13 /// Worried About Job Security
bhp_186_08 /// Worried About Crime
bhp_191 /// Both Parents Born In Germany
bhp_186_12 /// Worried Xenophobia in Germany
bhp_22_02 /// General-Education School Degree
bhp_52_isco08 /// Current occupation (ISCO-08 COM)
syear /// Survey Year
pid /// Never Changing Person ID
bhp_12 /// Maternity and Paternity leave
bhpbirthy /// Year of Birth 
bhp_33 /// employment status
bhp_14 /// registered unemployed
bhp_183 /// inclined towards a particular party
bhp_184_01 /// party identification
bhp_185 /// strenghy of party identification
bhp_01_06 /// satisfaction with personal income 
bhp_01_03 /// satisfaction with work
cid //


save "$Wdata/bhp.dta", replace

*2018
use "$Wdata/bip.dta", clear
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
bip_18v2 /// Paid work in the last seven days 
bip_19v2 /// Maternity and Paternity leave 
bip_60_q104 /// Both Parents Born In Germany
bip_170_08v2 ///
bip_29_02 /// General-Education School Degree
bip_170_12 /// Concern hostility towards foreigners or minorities in Germany
bip_61_isco08 /// Current occupation (ISCO-08)
syear /// Survey Year
pid /// Never Changing Person ID
bipbirthy /// Year of Birth 
cid ///
bip_173_01 /// lean towards which party
bip_01_03 /// satisfaction with work
bip_43 /// employment status
bip_01_06 /// satisfaction with personal income
bip_174 /// extent lean to party
bip_21 // registered unemployed
save "$Wdata/bip.dta", replace

/*Dataset with info on parents /// bioparen*/
use "$Wdata/bioparen.dta", clear
label language EN 
keep misco08 megp08 pid cid fnr mnr fsedu msedu fisei08 misei08 fmps08 mmps08 fsiops08 msiops08 fegp08 fisco08

save "$Wdata/bioparen.dta", replace

/*Dataset with edu info*/
use "$Wdata/bioedu.dta", clear
label language EN 
gen bex4certv2 = bex4cert
label var bex4certv2"highest school leaving certificate ever obtained"
lab def hedu -2 "does not apply" -1 "no answer" 1 "secondary school degree" 2 "intermediate school degree" 3 "technical school degree" 4 "upper secondary degree" 5 "other school degree" 6 "no school degree (yet), dropout"
label values bex4certv2 hedu

keep cid ///
pid ///
bex4cert ///
bex4cert2 //
save "$Wdata/bioedu.dta", replace

*pequiv
use "$Wdata/pequiv.dta", clear
keep syear pid cid hid ///
i11103 /// HH labor income
d11101 /// age of individual
l11102 /// region

save "$Wdata/pequiv.dta", replace

*pgen
use "$Wdata/pgen.dta", clear
keep imonth pid syear cid hid pgisced11
save "$Wdata/pgen.dta", replace
********2012*********

use "$Wdata/bchgen.dta", clear
keep hid syear cid nuts112 nuts112_ew
save "$Wdata/bchgen.dta", replace 

********2013*********
use "$Wdata/bdhgen.dta", clear
keep hid syear cid nuts113 nuts113_ew
save "$Wdata/bdhgen.dta", replace 

********2014*********
use "$Wdata/behgen.dta", clear
keep hid syear cid nuts114 nuts114_ew
save "$Wdata/behgen.dta", replace 

********2015*********
use "$Wdata/bfhgen.dta", clear
keep hid syear cid nuts115 nuts115_ew 
save "$Wdata/bfhgen.dta", replace 

********2016*********
use "$Wdata/bghgen.dta", clear
keep cid hid_2016 hid nuts116 nuts116_ew syear
save "$Wdata/bghgen.dta", replace 

********2017*********
use "$Wdata/bhhgen.dta", clear
keep cid hid syear nuts117 nuts117_ew
save "$Wdata/bhhgen.dta", replace 

********2018*********
use "$Wdata/bihgen.dta", clear
keep cid hid syear nuts118 nuts118_ew
save "$Wdata/bihgen.dta", replace

*********************************************************************
*MERGE
/*To merge we need to open a "Master" dataset. According to what I read in the SOEP website 
(https://companion.soep.de/Working%20with%20SOEP%20Data/How%20to%20Merge%20SOEP%20Data.html), and in the
SOEPtutorials: Data Structure and Naming Conventions, yt video
 we should choose PPATHL. */ 

use "$Wdata/ppathl.dta", clear
label language EN

*The command to merge consists in 4 parts:
*1 specify the kind of merge we want (e.g. 1:1)
*2 what are the key variables (identifiers)
*3 what dataset we want to add to the master
*4 (optional) specify which variables we want to take from the new dataset

merge 1:1 pid syear using "$Wdata/bcp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata/bdp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata/bep.dta"
drop _merge
merge 1:1 pid syear using "$Wdata/bfp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata/bgp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata/bhp.dta"
drop _merge
merge 1:1 pid syear using "$Wdata/bip.dta"
drop _merge
merge m:1 pid cid using "$Wdata/biojob.dta" 
drop _merge
merge m:1 pid cid using "$Wdata/bioparen.dta"
drop _merge
merge m:1 pid cid using "$Wdata/bioedu.dta"
drop _merge
merge 1:1 pid cid syear using "$Wdata/pequiv.dta"
drop _merge
merge 1:1 pid syear using "$Wdata/pgen.dta"
drop _merge
merge m:1 hid syear using "$Wdata/bchgen.dta" 
drop _merge
merge m:1 hid syear using "$Wdata/bdhgen.dta" 
drop _merge
merge m:1 hid syear using "$Wdata/behgen.dta" 
drop _merge
merge m:1 hid syear using "$Wdata/bfhgen.dta" 
drop _merge
merge m:1 hid syear using "$Wdata/bghgen.dta" 
drop _merge
merge m:1 hid syear using "$Wdata/bhhgen.dta" 
drop _merge
merge m:1 hid syear using "$Wdata/bihgen.dta" 
drop _merge

save "$Wdata/mergedataset", replace


clear all
