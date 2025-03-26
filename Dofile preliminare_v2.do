*Research design

********************************************************************************

global mydir "C:\Users\utente\OneDrive\Desktop\Research Design"
cd "$mydir"

global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
global odata "C:\Users\utente\OneDrive\Desktop\Research Design\Odata"
global dofile "C:\Users\utente\OneDrive\Desktop\Research Design\Dofile"

*per controllare i dataset nella cartella
dir

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
syear // survey year
*THE LIST IS NOT COMPLETE. WE STILL NEED VARIABLES ABOUT REGIONS, UNEMPLOYMENT AND SIMILAR


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
syear // Survey Year

save "$Wdata\bcp.dta", replace

*2013 

use "$Wdata\bdp.dta"
keep bdp13311 /// Worried About Immigration To Germany
bdp9001 /// General-Education School Degree
bdp13314 /// Worried About Job Security
bdp13310 /// worried about crime in germany
bdp13312 /// Worried About Hostility To Foreigners
bdp13301 /// Worried About Economic Development
bdp13309 /// Worried About global terrorism
bdp13403 /// Year Of Birth
bdp13401 /// Gender
bdp12 /// Paid Work In Last 7 Days
bdp13 /// Maternity, Paternity Leave
bdp146 /// Both Parents Born In Germany
bdp38_isco88 /// Current occupation (ISCO-88 COM)
pid /// Never Changing Person ID
syear // Survey Year

save "$Wdata\bdp.dta"
*2014
use "$Wdata\bep.dta"
keep bep12301 /// Worried About Economic Development
bep12308 /// worried about crime in germany
bep12309 /// Worried About Immigration To Germany
bep12310 /// Worried About Hostility To Foreigners
bep12311 /// Worried About Job Security
bep6902 /// General-Education School Degree
bep12603 /// Year Of Birth
bep12601 /// Gender
bep06 /// Paid Work In Last 7 Days
bep07 /// Maternity, Paternity Leave
bep132 /// Both Parents Born In Germany
bep28_isco88 /// Current occupation (ISCO-88 COM)
pid /// Never Changing Person ID
syear // Survey Year

save "$Wdata\bep.dta"

*2015
use "$Wdata\bfp.dta"
keep bfp14601 /// Worried About Economic Development
bfp14608 /// worried about crime in germany
bfp14610 /// Worried About Immigration To Germany
bfp14611 /// Worried About Hostility To Foreigners
bfp14612 /// Worried About Job Security
bfp2102 /// General-Education School Degree
bfp12 /// Paid Work In Last 7 Days
bfp13 /// Maternity, Paternity Leave
bfp52_isco88 /// Current occupation (ISCO-88 COM)
syear /// Survey Year
pid // Never Changing Person ID

save "$Wdata\bfp.dta"

*2016
use "$Wdata\bgp.dta"
keep bgp14801 /// Worried About Economic Development
bgp14808 /// worried about crime in germany
bgp14810 /// Worried About Immigration To Germany
bgp14811 /// Worried About Hostility To Foreigners
bgp14812 /// Worried About Job Security
bgp10 /// Paid Work In Last 7 Days
bgp2102 /// General-Education School Degree
bgp11a /// Maternity, Paternity Leave > in the dataset there's no "a"
bgp2107_isco88 /// Vocation (ISCO-88 COM)
syear /// Survey Year
pid // Never Changing Person ID

save "$Wdata\bgp.dta"

*2017
use "$Wdata\bhp.dta"
keep bhp_186_01 /// Worried About Economic Development
bhp_186_11 /// Worried About Immigration to Germany
bhp_186_13 /// Worried About Job Security
bhp_186_08 /// Worried About Crime
bhp_186_12 /// Worried Xenophobia in Germany
bhp_22_02 /// General-Education School Degree
bhp_11 /// Work Last Seven Days
bhp_122_08 /// Maternity, Paternity Leave
bhp_52_isco88 /// Current occupation (ISCO-88 COM)
syear /// Survey Year
pid // Never Changing Person ID

save "$Wdata\bhp.dta"

*2018

use "$Wdata\bip.dta"
keep bip_170_01 /// Worried About Economic Development
bip_170_11 /// Worried About Immigration to Germany
bip_170_13 /// Worried About Job Security
bip_18 /// Work Last Seven Days
bip_29_02 /// General-Education School Degree
bip_170_12 /// Concern hostility towards foreigners or minorities in Germany
bip_170_08 /// Concern crime in Germany
bip_19 /// Maternity, Paternity Leave
bip_61_isco08 /// Current occupation (ISCO-08)
syear /// Survey Year
pid // Never Changing Person ID

save "$Wdata\bip.dta"

*2019
use "$Wdata\bjp.dta"
keep bjp_174_12 ///
bjp_174_08 ///
bjp_174_11 ///
bjp_174_13 ///
bjp_174_01 ///
bjp_12_02 ///
bjp_08 /// 
bjp_07 ///
bjp_46_isco08 ///
syear ///
pid //
save "$Wdata\bjp.dta"
*REPEAT THE PROCEDURE FOR ALL THE WAVES
*********************************************************************
*Merge

/*To merge we need to open a "Master" dataset. According to what I read in the SOEP website 
(https://companion.soep.de/Working%20with%20SOEP%20Data/How%20to%20Merge%20SOEP%20Data.html), and in the
SOEPtutorials: Data Structure and Naming Conventions, yt video
 we should choose PPATHL. */ 

use "$Wdata\ppathl.dta"

*The command to merge consists in 4 parts:
*1 specify the kind of merge we want (e.g. 1:1)
*2 what are the key variables (identifiers)
*3 what dataset we want to add to the master
*4 (optional) which variables we want to take from the new dataset

merge 1:1 pid using "$Wdata\bbp.dta"
merge 1:1 pid using "$Wdata\bcp.dta"
merge 1:1 pid using "$Wdata\bdp.dta"
merge 1:1 pid using "$Wdata\bep.dta"
merge 1:1 pid using "$Wdata\bfp.dta"
merge 1:1 pid using "$Wdata\bgp.dta"
merge 1:1 pid using "$Wdata\bhp.dta"
merge 1:1 pid using "$Wdata\bip.dta"


*I saw from many sources that as key variables we should use both pid and syear (survey year). 
*However in PPATHL the variable doesn't exists. What to do?




































