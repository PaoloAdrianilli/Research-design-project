global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
use "$Wdata/recodata.dta", clear

label language EN
xtset pid syear

misstable summarize v_whosmi v_wjose v_wocri v_woeco v_wormi 

keep pid syear bex4cert v_whosmi v_wjose v_wocri v_woeco v_wormi sex bothprntsgerman time_dummy i11103


foreach var in pid syear v_whosmi v_wjose v_wocri v_woeco v_wormi i11103{
	drop if `var' ==.
	}
	
* Make sure data is sorted by panel ID and year
sort pid syear

* Genera la variabile delle differenze prime per wocri
by pid: gen d_wocri = v_wocri - v_wocri[_n-1] if syear == syear[_n-1] + 1

* Genera le differenze prime per le tue variabili indipendenti
* Ad esempio, se hai variabili indipendenti x1, x2, x3:
by pid: gen d_bex4cert = bex4cert - bex4cert[_n-1] if syear == syear[_n-1] + 1
by pid: gen d_i11103 = i11103 - i11103[_n-1] if syear == syear[_n-1] + 1
by pid: gen d_x3 = x3 - x3[_n-1] if syear == syear[_n-1] + 1

* Esegui la regressione first difference
gen D_v_wocri = D.v_wocri

* Calcola la differenza delle indipendenti
gen D_i11103 = D.i11103
gen D_sex = D.sex
gen D_bothprntsgerman = D.bothprntsgerman
gen D_time_dummy = D.time_dummy

* Adesso fai la regressione OLS su differenze
reg D_v_wocri D_time_dummy


twoway (lfit D_v_wocri D_time_dummy, lcolor(blue) lwidth(medium)), ///
    title("Effetto del cambiamento del reddito sulla preoccupazione per il crimine") ///
    ytitle("Δ Preoccupazione") ///
    xtitle("Δ Reddito familiare") ///
    legend(off)










* Prevedere i valori fitted (valori stimati della variazione)
predict D_v_wocri_hat, xb

* Se hai ancora "syear" disponibile (non hai collassato), puoi disegnare:
scatter D_v_wocri_hat syear, ///
    title("Variazione prevista della preoccupazione per il crimine") ///
    ytitle("Variazione stimata") ///
    xtitle("Anno") ///
    msymbol(circle) mcolor(red)





	collapse (mean) D_v_wocri, by(syear)

* Line chart della variazione media
twoway (line D_v_wocri syear, lcolor(blue) lwidth(medium)), ///
    title("Variazione media annuale nella preoccupazione per il crimine") ///
    ytitle("Δ Preoccupazione per il crimine") ///
    xtitle("Anno") ///
    ylabel(, grid) ///
    xlabel(, grid)




















preserve
collapse (mean) d_wocri, by(syear)
line d_wocri syear, title("Variazione media annuale nella preoccupazione per il crimine") ///
  ytitle("Variazione media") xtitle("Anno")
restore



tab  syear d_wocri


margins sex, atmeans
marginsplot, title("Variazione nella preoccupazione per il crimine per genere") ///
  ytitle("Variazione prevista") xtitle("Genere")


margins, at(bex4cert=(0(10)100)) atmeans
marginsplot, title("Effetto di bex4cert sulla variazione della preoccupazione per il crimine") ///
  ytitle("Variazione prevista nella preoccupazione per il crimine") ///
  xtitle("Livello di certezza")

