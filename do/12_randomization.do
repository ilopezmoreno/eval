clear

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



Alternately, you can run the simplest equation that regresses per capita expenditure 
against the village program dummy:
reg lexptot progvillf;
The result gives the same effect (0.130), which is signifi cant.
