*Research design

********************************************************************************

global mydir "C:\Users\utente\OneDrive\Desktop\Research Design"
cd "$mydir"

global wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
global odata "C:\Users\utente\OneDrive\Desktop\Research Design\Odata"
global dofile "C:\Users\utente\OneDrive\Desktop\Research Design\Dofile"

*per controllare i dataset nella cartella
dir

********************************************************************************
*Merging the different SOEP waves

******************** Choosing the variables
*2011
use "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata\bbp.dta", clear 
label language EN
keep bbp13101 ///
bbp8401 ///
bbp13113 ///
bbp13109 ///
bbp13111 ///
bbp13101 ///
bbp04 ///
bbp0501 ///
bbp135 ///
bbp13201 ///
bbp13202 ///
bbp28_isco88 ///
bbp0501 ///
bbp9109 ///
pid ///
syear //
*THE LIST IS NOT COMPLETE. WE STILL NEED VARIABLES ABOUT REGIONS, UNEMPLOYMENT AND SIMILAR


save "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata\bbp.dta", replace

*2012
use "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata\bcp.dta", clear 
label language EN

keep bcp12701 ///
bcp12708 ///
bcp12709 ///
bcp12710 ///
bcp12711 ///
bcp12713 ///
bcp7201 ///
bcp12803 ///
bcp12801 ///
bcp142 ///
pid ///
syear //

save "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata\bcp.dta", replace

*2013 

use
keep bdp13311 ///
bdp9001 ///
bdp13314 ///
bdp13310 /// 
bdp13312 ///
bdp13301 ///
bdp13309 ///
bdp13403 ///
bdp13401 ///
bdp12 ///
bdp13 ///
bdp146 ///
pid ///
syear //

save
*2014
use 
keep bep12301 ///
bep12308 /// 
bep12309 ///
bep12310 ///
bep12311 /// 
bep6902 /// 
bep12603 /// 
bep12601 /// 
bep06 ///
bep07 /// 
bep132 ///
pid ///
syear //

save

*2015
use
keep bfp14601 ///
bfp14608 ///
bfp14610 ///
bfp14611 ///
bfp14612 ///
bfp2102 ///
bfp12 ///
bfp13 ///
syear ///
pid //

save

*2016
use 
keep bgp14801 ///
bgp14808 /// 
bgp14810 ///
bgp14811 ///
bgp14812 ///
bgp10 ///
bgp2102 ///
bgp11a ///
syear ///
pid //

save

*2017
use
keep bhp_186_01 ///
bhp_186_11 ///
bhp_186_13 ///
bhp_186_08 ///
bhp_186_12 ///  this one is xenofobia
bhp_22_02 ///
bhp_11 ///
bhp_122_08 ///
syear ///
pid //

save

*2018

use
keep bip_170_01 ///
bip_170_11 ///
bip_170_13 ///
bip_18 bip_19 ///
bip_29_02 ///
bip_170_12 ///
bip_170_08 ///
bip_19 ///
syear ///
pid //

*REPEAT THE PROCEDURE FOR ALL THE WAVES
*********************************************************************
*Merge

/*To merge we need to open a "Master" dataset. According to what I read in the SOEP website 
(https://companion.soep.de/Working%20with%20SOEP%20Data/How%20to%20Merge%20SOEP%20Data.html), and in the
SOEPtutorials: Data Structure and Naming Conventions, yt video
 we should choose PPATHL. */ 

use "C:\Users\utente\OneDrive\Desktop\Research Design\Odata\Files (7) from SOEP - Antonia Meier\SOEP-CORE.v39eu_Stata\Stata_DE\soepdata\ppath.dta"

*The command to merge consists in 4 parts:
*1 specify the kind of merge we want (e.g. 1:1)
*2 what are the key variables (identifiers)
*3 what dataset we want to add to the master
*4 (optional) which variables we want to take from the new dataset

merge 1:1 pid using "$wdata\bbp.dta"
merge 1:1 pid using "$wdata\bcp.dta"
merge 1:1 pid using "$wdata\bdp.dta"
merge 1:1 pid using "$wdata\bep.dta"
merge 1:1 pid using "$wdata\bfp.dta"
merge 1:1 pid using "$wdata\bgp.dta"
merge 1:1 pid using "$wdata\bhp.dta"
merge 1:1 pid using "$wdata\bip.dta"


*I saw from many sources that as key variables we should use both pid and syear (survey year). 
*However in PPATHL the variable doesn't exists. What to do?




































