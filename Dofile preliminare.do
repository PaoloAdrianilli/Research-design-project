*Research design

********************************************************************************

*voglio unire le diverse wave del SOEP


global mydir "C:\Users\utente\OneDrive\Desktop\Research Design"
cd "$mydir"

global wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
global odata "C:\Users\utente\OneDrive\Desktop\Research Design\Odata"
global dofile "C:\Users\utente\OneDrive\Desktop\Research Design\Dofile"

*per controllare i dataset nella cartella
dir

******************** Cleaning the dataset
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

save "C:\Users\utente\OneDrive\Desktop\temp", replace
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

save "C:\Users\utente\OneDrive\Desktop\temp1", replace
save "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata\bcp.dta", replace

*merge
use "C:\Users\utente\OneDrive\Desktop\temp", clear
use "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata\bbp.dta", clear

merge 1:1 pid using "C:\Users\utente\OneDrive\Desktop\temp1.dta", keepusing(syear pid bcp7201 bcp12701 bcp12708 bcp12709 bcp12710 bcp12711 bcp12713 bcp12801 bcp12803 bcp142)

*ci sono un migliaio di casi di meno tra i due dataset. sarebbe meglio usare come master il dataset con più casi di tutti?



**** per vedere se le variabili sono comuni tra dataset Se merge == 3 è basso, significa che le osservazioni combaciano poco → serve armonizzazione.
use wave1.dta, clear
merge 1:1 id using wave2.dta, keepusing(var1 var2 var3) gen(_merge)

*bisogna cercare le variabili da tenere e non portarsi dietro tutto






use "C:\Users\utente\OneDrive\Desktop\Research Design\Odata\Files (7) from SOEP - Antonia Meier\SOEP-CORE.v39eu_Stata\Stata_DE\soepdata\ppath.dta"

merge 1:1 pid using "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata\bcp.dta"












