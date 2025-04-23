global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
use "$Wdata\recodata", clear
label language EN
xtset pid syear

*random descriptives of HHincome of the respondent
xtsum i11103
bysort syear: sum i11103
tabstat i11103, by(syear) stat(mean)
preserve
collapse (mean) i11103_mean=i11103, by(syear)
line i11103_mean syear, sort
restore
twoway (connected mean syear), by(i11103)
bysort syear: egen mean_income = mean(i11103)
twoway connected mean_income syear

preserve
collapse (mean) wormi_mean=wormi, by(syear)
line wormi_mean syear, sort
restore

graph bar (mean) i11103, over(syear)