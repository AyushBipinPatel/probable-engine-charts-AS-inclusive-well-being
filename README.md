# probable-engine-charts-AS-inclusive-well-being
Repo contains code to create charts as requested by Suman for the Inclusive Absolute Well-being Changes: An Application with Multidimensional Cross-country Analysis paper

## Instructions from Suman

With this email, I am attaching the data that Ayush may require to reproduce Figures 1, 2 and 3. He will be requiring the following variables.

 
ISO: ISO

d_attain_pa: Change in average attainment per annum

S_W_Sen_pa: Inclusivity premium per annum

abs_M0_33_pa: Absolute change in MPI per annum

inc_shr_pre: Shared prosperity premium (SPP) per annum (World Bank shared prosperity premium)

Figure 1: S_W_Sen_pa and d_attain_pa

Figure 2: inc_shr_pre and S_W_Sen_pa

Figure 3: abs_M0_33_pa and S_W_Sen_pa

For all figures, we use the qfit (quadratic fit) option with twoway graph, which “calculates the prediction for yvar from a linear regression of yvar on xvar and xvar2 and plots the resulting curve.” Thus, in excel, you may need to use the option polynomial of order 2 while fitting the trendlines.