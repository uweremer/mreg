# Videoserie Mehrebenenregression mit R 
# Teil 4/6 
# Wie findet man das passende Modell für die Mehrebenenregression?
# Dr. Uwe Remer




# Ausführen des Scriptes aus Video 3
# Das enthält die Vorbereitung der Daten
source("./RScript_mreg3.R") #Pfad zur Datei ggf. anpassen




#### Varying Intercept, Varying Slope Modell ####

library(lmerTest) 
mreg3 <- lmer(pol_vertrauen ~ 1 + bildung + 
                responsivitaet + zufr_wirtschaft + soz_vertrauen + 
                korruption + bildung_agg +
                (1 + bildung | cntry),     #Hier wird der variierende Slope spezifiziert
              data=ess)

summary(mreg3)

## # Nicht ausführen
## mreg <- lmer(y ~ 1 + x + (1 + grp),
##              data = df,
##              REML = TRUE)


# Per default werden die Modelle mit ML refittet:
anova(mreg1, mreg2)
#anova(mreg1, mreg2, refit=T)

anova(mreg2, mreg3, refit=F)

# Anzeigen der random effects
ranef(mreg3)


# Berechnen der variierenden Intercepts
re_bildung <- ranef(mreg3)$cntry[,2]
names(re_bildung) <- row.names(ranef(mreg3)$cntry)

#re_bildung+fixef(mreg2)[2]
sort(re_bildung+fixef(mreg2)[2])


#### Cross Level Interaktion #### 

mreg4 <- lmer(pol_vertrauen ~ 1 + bildung + 
                responsivitaet + zufr_wirtschaft + soz_vertrauen + 
                korruption + bildung_agg +
                bildung:korruption + #Hier wird die Cross-Level Interaktion speifiziert
                (1 + bildung | cntry),  
              data=ess)
anova(mreg3, mreg4, refit=T)

performance::r2(mreg4)

summary(mreg4)
