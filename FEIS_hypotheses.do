global Wdata "/Users/andreazuliani/Desktop/New_research/Wdata"
use "$Wdata/recodata.dta", clear
label language EN
xtset pid syear


gen r_syear = syear 
replace r_syear = 20155 if syear == 2015 & imonth <= 5
replace r_syear = 20156 if syear == 2015 & imonth >= 6

**************
*FEIS - WORMI*
**************

************
*Null Model*
************

xtfeis v_wormi miss_v_wormi i.r_syear, cluster(pid) 
eststo NullModel

***********************
*FEIS with crime (HY1)*
***********************

xtfeis v_wormi i.v_wocri miss_v_wormi miss_v_wocri i.r_syear, cluster(pid)
eststo Model1

*********************
*FEIS with eco (HY2)*
*********************

xtfeis v_wormi i.v_wocri i.v_woeco loghhincome miss_v_wormi miss_v_wocri miss_v_woeco i.r_syear, cluster(pid)
eststo Model2

*********************
*FEIS with eco (HY2)*
*********************

xtfeis v_wormi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun miss_v_wormi miss_v_wocri miss_v_woeco i.r_syear, cluster(pid) 
eststo Model3

*********************
*FEIS with eco (HY3)*
*********************

xtfeis v_wormi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun ib3.edu_level miss_v_wormi miss_v_wocri miss_v_woeco i.r_syear, cluster(pid)
eststo Model4

esttab NullModel Model1 Model2 Model3 Model4 using results_new.rtf, replace se label


***************
*FEIS - WHOSMI*
***************

************
*Null Model*
************

xtfeis v_whosmi miss_v_whosmi i.r_syear, cluster(pid)
eststo NullModel

***********************
*FEIS with crime (HY1)*
***********************

xtfeis v_whosmi i.v_wocri miss_v_whosmi miss_v_wocri i.r_syear, cluster(pid)
eststo Model1

*********************
*FEIS with eco (HY2)*
*********************

xtfeis v_whosmi i.v_wocri i.v_woeco loghhincome miss_v_whosmi miss_v_wocri miss_v_woeco i.r_syear, cluster(pid)
eststo Model2

*********************
*FEIS with eco (HY2)*
*********************

xtfeis v_whosmi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun miss_v_whosmi miss_v_wocri miss_v_woeco i.r_syear, cluster(pid)
eststo Model3

*********************
*FEIS with eco (HY3)*
*********************

xtfeis v_whosmi i.v_wocri i.v_woeco loghhincome ib5.emplstus i.regun ib3.edu_level miss_v_whosmi miss_v_wocri miss_v_woeco i.r_syear, cluster(pid)
eststo Model4

esttab NullModel Model1 Model2 Model3 Model4 using results_new.rtf, replace se label

save "$Wdata/recodata.dta", replace


