use "C:\Users\bussse\Dropbox\Research\Sabina\Shared prosperity\Alkire-Seth inclusive well-being data for graphs.dta", clear


// Generating the trendlines for Figure 1
gen d_attain_pa_sq = d_attain_pa^2 // Square of d_attain_pa

reg S_W_Sen_pa d_attain_pa d_attain_pa_sq [aw= population]
predict Fig1_solid_black

reg S_W_Sen_pa d_attain_pa d_attain_pa_sq
predict Fig1_solid_grey

reg S_W_Sen_pa d_attain_pa d_attain_pa_sq if ISO!="LAO"
predict Fig1_dashed_grey if ISO!="LAO"

sort d_attain_pa
graph twoway (line Fig1_solid_black d_attain_pa, lcolor(black)) (line Fig1_solid_grey d_attain_pa, lcolor(gray)) (line Fig1_dashed_grey d_attain_pa if ISO!="LAO", lcolor(gray) lpattern(dash)), ylabel(-0.25(0.25)1,format(%9.2f) angle(horizontal) labsize(4)) xlabel(-0.3(0.3)2.2,format(%9.1f) grid labsize(4))


// Genrating the trendlines for Figure 2
gen S_W_Sen_pa_sq = S_W_Sen_pa^2 // Square of inc_shr_pre
gen x=1 if ISO=="ALB" | ISO=="ARM" | ISO=="CHN" | ISO=="COL" | ISO=="DOM" | ISO=="EGY" | ISO=="GHA" | ISO=="IDN" | ISO=="KAZ" | ISO=="LAO" | ISO=="MNE" | ISO=="MNG" | ISO=="MWI" | ISO=="PAK" | ISO=="PER" | ISO=="PHL" | ISO=="PSE" | ISO=="RWA" | ISO=="SLE" | ISO=="SRB" | ISO=="THA" | ISO=="TZA" | ISO=="UGA" | ISO=="VNM" | ISO=="ZWE"

gen y = .
sum S_W_Sen_pa if x==1
local i = (r(max) - r(min))/79
replace y = r(min) in 1
forvalues r = 2(1)80 {
local q=`r'-1
replace y = y[`q'] + `i' in `r'
}

reg inc_shr_pre S_W_Sen_pa S_W_Sen_pa_sq [aw=population] if x==1
gen Fig2_solid_black = _b[_cons] + _b[S_W_Sen_pa]*y + _b[S_W_Sen_pa_sq]*y^2

reg inc_shr_pre S_W_Sen_pa S_W_Sen_pa_sq if x==1
gen Fig2_solid_gray = _b[_cons] + _b[S_W_Sen_pa]*y + _b[S_W_Sen_pa_sq]*y^2

sort y
graph twoway (line Fig2_solid_black y, lcolor(black)) (line Fig2_solid_gray y, lcolor(gray)), xlabel(-0.2(0.2)1.1,format(%9.2f) grid) ylabel(-2(1)4,format(%9.1f) angle(horizontal))


// Genrating the trendlines for Figure 3
reg abs_M0_33_pa S_W_Sen_pa S_W_Sen_pa_sq [aw=population]
predict Fig3_solid_black

reg abs_M0_33_pa S_W_Sen_pa S_W_Sen_pa_sq
predict Fig3_solid_gray

sort S_W_Sen_pa
graph twoway (line Fig3_solid_black S_W_Sen_pa, lcolor(black)) (line Fig3_solid_gray S_W_Sen_pa, lcolor(gray)), xlabel(-0.25(0.25)1,format(%9.2f) grid) ylabel(-0.03(0.005)0.005,format(%9.3f) angle(horizontal))

save "C:\Users\bussse\Dropbox\Research\Sabina\Shared prosperity\Alkire-Seth Trend-line data included.dta", replace
