global Wdata "C:\Users\utente\OneDrive\Desktop\Research Design\Wdata"
*READ LINE 8/9
use "$Wdata/recodata4fa.dta", clear
label language EN
xtset pid syear

local vars v_whosmi v_wormi v_wocri

forvalues y = 2012/2018 {
    foreach v of local vars {
        gen `v'`y' = .
        replace `v'`y' = `v' if syear == `y'
    }
}

*Since we are not able of doing a factor analysis through structured equation models we will conduct a PCFA for each year in order to see if over time the factors loaded differently

factor v_whosmi2012 v_wormi2012 v_wocri2012, pcf
factor v_whosmi2013 v_wormi2013 v_wocri2013, pcf
factor v_whosmi2014 v_wormi2014 v_wocri2014, pcf
factor v_whosmi2015 v_wormi2015 v_wocri2015, pcf
factor v_whosmi2016 v_wormi2016 v_wocri2016, pcf
factor v_whosmi2017 v_wormi2017 v_wocri2017, pcf
factor v_whosmi2018 v_wormi2018 v_wocri2018, pcf

*with woeco
factor v_woeco2012 v_whosmi2012 v_wormi2012 v_wocri2012, pcf
factor v_woeco2013 v_whosmi2013 v_wormi2013 v_wocri2013, pcf
factor v_woeco2014 v_whosmi2014 v_wormi2014 v_wocri2014, pcf
factor v_woeco2015 v_whosmi2015 v_wormi2015 v_wocri2015, pcf
factor v_woeco2016 v_whosmi2016 v_wormi2016 v_wocri2016, pcf
factor v_woeco2017 v_whosmi2017 v_wormi2017 v_wocri2017, pcf
factor v_woeco2018 v_whosmi2018 v_wormi2018 v_wocri2018, pcf


*for every year these three variables are explained by only one factor

factor v_whosmi2012 v_wormi2012 v_wocri2012, ml factors(2)
factor v_whosmi2013 v_wormi2013 v_wocri2013, ml factors(2)
factor v_whosmi2014 v_wormi2014 v_wocri2014, ml factors(2)
factor v_whosmi2015 v_wormi2015 v_wocri2015, ml factors(2)
factor v_whosmi2016 v_wormi2016 v_wocri2016, ml factors(2)
factor v_whosmi2017 v_wormi2017 v_wocri2017, ml factors(2)
factor v_whosmi2018 v_wormi2018 v_wocri2018, ml factors(2)

factor v_woeco2012 v_whosmi2012 v_wormi2012 v_wocri2012,  ml factors(2)
factor v_woeco2013 v_whosmi2013 v_wormi2013 v_wocri2013,  ml factors(2)
factor v_woeco2014 v_whosmi2014 v_wormi2014 v_wocri2014,  ml factors(2)
factor v_woeco2015 v_whosmi2015 v_wormi2015 v_wocri2015,  ml factors(2)
factor v_woeco2016 v_whosmi2016 v_wormi2016 v_wocri2016,  ml factors(2)
factor v_woeco2017 v_whosmi2017 v_wormi2017 v_wocri2017, ml factors(2)
factor v_woeco2018 v_whosmi2018 v_wormi2018 v_wocri2018,  ml factors(2)


*it's the same using the maximum likelihood as means of estimation

*that single factor explains a big part of the variance of the items, however
*the explained variance is not stable during the years is slighlty U shaped 
*it starts high, it goes down until 2015 to rise again afterwards, reaching the starting level
