clear


*** 1 - Impacts of Program Placement in Villages ***

* For this exercise, use the 1998 household data hh_98.dta.
use C:\Users\d57917il\Documents\GitHub\eval\data\hh_98.dta

/* Create the log form of two variables 
— outcome (“exptot”) and 
— household’s land before joining the microcredit program “hhland,” 
which is changed to acre from decimal by dividing by 100 */
gen lexptot=ln(1+exptot)
gen lnland=ln(1+hhland/100)


/* Then a dummy variable is created for microcredit program placement in villages. 
Two program placement variables are created: 
one for male programs and the other for female programs. */
gen vill=thanaid*10+villid
egen progvillm=max(dmmfd), by(vill)
egen progvillf=max(dfmfd), by(vill)


/* Now use the simplest method to calculate average treatment effect of village 
program placement. It is done by using the Stata “ttest” command.
This command compares the outcome between treated and control villages. */
ttest lexptot, by(progvillf)
/* The result shows that the difference of outcomes between treated and 
control villages is significant. Which means that female program placement 
in villages improves per capita expenditure */ 


/* Alternately, you can run the simplest equation that 
regresses per capita expenditure against the village program dummy: */
reg lexptot progvillf
/* The result gives the same effect (0.130), and it is statistically significant. 
The previous regression estimates the overall impact of the village programs on 
the per capita expenditure of households. It may be different from the impact on the 
expenditure after holding other factors constant — that is, specifying the model adjusted 
for covariates that affect the outcomes of interest. 


Now, regress the same outcome (log of per capita household expenditures) 
against the village program dummy plus other factors that may influence the expenditure. */
reg lexptot progvillf sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]
* After considering other covariates, the results indicate that the impact of the program is not statistically significant. 








*** 2 - Impacts of Program Participation *** 

/* Even though microcredit program assignment is random across villages, the participation may not be. 
Only those households that have fewer than 50 decimals of land can participate in microcredit programs (so-called target groups). 

As before, start this exercise with the simplest method to calculate average treatment effect 
of program participation for females. It is done by using the Stata “ttest” command, which 
compares the outcome between treated and control villages. */
ttest lexptot, by(dfmfd)
* The result shows that the difference of outcomes between participants and nonparticipant is insignificant. 


* Alternately, you can run the simple regression model—outcome against female participation:
reg lexptot dfmfd
* The regression illustrates that the effect of female participation in microcredit programs is not different from zero.


* Now, similarly to the regression of village program placement, include other household- and village- level covariates 
* in the female participation equation:
reg lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]
* The results show that female participation impact to household expenditure has now changed from insignificant to signifi cant (10 percent level).











*** 3 - Capturing Both Program Placement and Participation *** 

* The previous two exercises showed in separate regressions the effects of program placement and program participation. 
* However, these two effects can be combined in the same regression, which gives a more unbiased estimate.
reg lexptot dfmfd progvillf sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg [pw=weight]
* The results show no significant effect of program placement 
* but a positive significant effect (7.3 percent) of female program participants (t = 2.05).




*** 4 - Impacts of Program Participation in Program Villages *** 

* Now, see if program participation matters for households living in program villages. 
* Start with the simple model, and restrict the sample to program villages:
reg lexptot dfmfd if progvillf==1 [pw=weight]
/* The result shows that the impact of female participation in microcredit programs 
on household expenditure in program villages is in fact negative. 
Female participation lowers per capita expenditure of households in program villages by 7.0 percent. */ 


* Now regress the extended model (that is, including other variables that infl uence the total expenditures
reg lexptot dfmfd sexhead agehead educhead lnland vaccess pcirr rice wheat milk oil egg if progvillf==1 [pw=weight]
* By keeping all other variables constant, you can see that female participation becomes positive and is signifi cant at the 10 percent level.





