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


factor v_whosmi2012 v_wormi2012 v_wocri2012, pcf
factor v_whosmi2013 v_wormi2013 v_wocri2013, pcf
factor v_whosmi2014 v_wormi2014 v_wocri2014, pcf
factor v_whosmi2015 v_wormi2015 v_wocri2015, pcf
factor v_whosmi2016 v_wormi2016 v_wocri2016, pcf
factor v_whosmi2017 v_wormi2017 v_wocri2017, pcf
factor v_whosmi2018 v_wormi2018 v_wocri2018, pcf

*for every year these three variables are explained by only one factor

factor v_whosmi2012 v_wormi2012 v_wocri2012, ml
factor v_whosmi2013 v_wormi2013 v_wocri2013, ml
factor v_whosmi2014 v_wormi2014 v_wocri2014, ml
factor v_whosmi2015 v_wormi2015 v_wocri2015, ml
factor v_whosmi2016 v_wormi2016 v_wocri2016, ml
factor v_whosmi2017 v_wormi2017 v_wocri2017, ml
factor v_whosmi2018 v_wormi2018 v_wocri2018, ml


*it's the same using the maximum likelihood as means of estimation

*that signle factor explains a big part of the variance of the items, howver
*the explained variance is not stable during the years is U shaped 
*it starts high, it goes down until 2015 to rise again afterwards, reaching the starting level


















misstable summarize v_whosmi v_wjose v_wocri v_woeco v_wormi
/* To do a longitudinal CFA I need to reshape the dataset wide. So I decided to
keep only the variable that I ll utilize. BE CAREFUL to not overwrite recodata */
keep pid syear v_whosmi v_wjose v_wocri v_woeco v_wormi
reshape wide v_whosmi v_wjose v_wocri v_woeco v_wormi, i(pid) j(syear)


gsem (Factor2012 -> v_wormi2012 v_wocri2012 v_whosmi2012) ///
     (Factor2013 -> v_wormi2013 v_wocri2013 v_whosmi2013) ///
     (Factor2014 -> v_wormi2014 v_wocri2014 v_whosmi2014) ///
     (Factor2015 -> v_wormi2015 v_wocri2015 v_whosmi2015) ///
     (Factor2016 -> v_wormi2016 v_wocri2016 v_whosmi2016) ///
     (Factor2017 -> v_wormi2017 v_wocri2017 v_whosmi2017) ///
     (Factor2018 -> v_wormi2018 v_wocri2018 v_whosmi2018), ///
     family(ordinal) link(logit) method(ml)







*I'll procede with the SEM (Structured equation modeling, with maximum likelihood)
*family(ordinal) should specify the nature of our data 
gsem (Factor2012 -> v_wormi2012 v_wocri2012 v_woeco2012 v_whosmi2012 v_wjose2012) ///
     (Factor2013 -> v_wormi2013 v_wocri2013 v_woeco2013 v_whosmi2013 v_wjose2013) ///
     (Factor2014 -> v_wormi2014 v_wocri2014 v_woeco2014 v_whosmi2014 v_wjose2014) ///
     (Factor2015 -> v_wormi2015 v_wocri2015 v_woeco2015 v_whosmi2015 v_wjose2015) ///
     (Factor2016 -> v_wormi2016 v_wocri2016 v_woeco2016 v_whosmi2016 v_wjose2016) ///
     (Factor2017 -> v_wormi2017 v_wocri2017 v_woeco2017 v_whosmi2017 v_wjose2017) ///
     (Factor2018 -> v_wormi2018 v_wocri2018 v_woeco2018 v_whosmi2018 v_wjose2018),
     family(ordinal) link(logit) method(ml)

/*This second model assumes that loadings are constant (is a way of testing it).
l1 l2 l3 l4 are the loadings forced to remain equal*/
gsem (Fattore2012 -> v_whosmi2012@1 v_wjose2012@l1 v_wocri2012@l2 v_woeco2012@l3 v_wormi2012@l4) ///
     (Fattore2013 -> v_whosmi2013@1 v_wjose2013@l1 v_wocri2013@l2 v_woeco2013@l3 v_wormi2013@l4) ///
     (Fattore2014 -> v_whosmi2014@1 v_wjose2014@l1 v_wocri2014@l2 v_woeco2014@l3 v_wormi2014@l4) ///
     (Fattore2015 -> v_whosmi2015@1 v_wjose2015@l1 v_wocri2015@l2 v_woeco2015@l3 v_wormi2015@l4) ///
     (Fattore2016 -> v_whosmi2016@1 v_wjose2016@l1 v_wocri2016@l2 v_woeco2016@l3 v_wormi2016@l4) ///
     (Fattore2017 -> v_whosmi2017@1 v_wjose2017@l1 v_wocri2017@l2 v_woeco2017@l3 v_wormi2017@l4) ///
     (Fattore2018 -> v_whosmi2018@1 v_wjose2018@l1 v_wocri2018@l2 v_woeco2018@l3 v_wormi2018@l4),
     family(ordinal) link(logit) method(mlmv)
