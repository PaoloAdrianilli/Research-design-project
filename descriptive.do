global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
use "$Wdata\recodata", clear
label language EN
xtset pid syear

*random descriptives of HHincome of the respondent
xtsum i11103
bysort syear: sum i11103
tabstat i11103, by(syear) stat(mean)

/*be careful to run the entire command at once (from preserve to restore). 
It produces the same result as the next command but it is quicker*/
********************************************************************************
preserve
collapse (mean) i11103_mean=i11103, by(syear)
line i11103_mean syear, sort
restore

*
preserve
collapse (mean) v_wormi_mean=v_wormi, by(syear)
line v_wormi_mean syear, sort
restore
***************************
bysort syear: egen mean_i11103 = mean(i11103)
twoway connected mean_i11103 syear
********************************************************************************
* Two ways of plotting the same thing (I prefer the second one).   | WORRIES |
********************************************************************************
graph bar (mean) v_wormi, over(syear) name(g1, replace)
graph bar (mean) v_wjose, over(syear) name(g2, replace)
graph bar (mean) v_whosmi, over(syear) name(g3, replace)
graph bar (mean) v_woeco, over(syear) name(g4, replace)
graph bar (mean) v_wocri, over(syear) name(g5, replace)

graph combine g1 g2 g3 g4 g5, cols(2) title("Means by year")

foreach var in v_wormi v_whosmi v_wjose v_wocri v_woeco {
	bysort syear: egen mean_`var' = mean(`var')
}

twoway connected mean_v_wormi syear, name(g1, replace)
twoway connected mean_v_wjose syear, name(g2, replace)
twoway connected mean_v_whosmi syear, name(g3, replace)
twoway connected mean_v_wocri syear, name(g4, replace)
twoway connected mean_v_woeco syear, name(g5, replace)
graph combine g1 g2 g3 g4 g5, cols(2) title("Means by year")
*wocri, wormi, whosmi have a similiar pattern, woeco and wojose are basically still
*********************************************************************************
graph bar (mean) i11103, over(syear)
