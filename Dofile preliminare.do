*Research design

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

merge 1:1 pid using "C:\Users\utente\OneDrive\Desktop\temp1.dta", keepusing(syear pid bcp7201 bcp12701 bcp12708 bcp12709 bcp12710 bcp12711 bcp12713 bcp12801 bcp12803 bcp142)

*I saw from many sources that as key variables we should use both pid and syear (survey year). 
*However in PPATHL the variable doesn't exists. What to do?
























