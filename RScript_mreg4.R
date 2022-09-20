# Videoserie Mehrebenenregression mit R 
# Teil 4/6 
# Wie schätzt man eine Mehrebenenregression in R?
# Dr. Uwe Remer


# R Skript aus Video 3 ausführen lassen, damit Daten und
# vorbereitete Variablen vorhanden sind:
source("./RScript_mreg3.R") 
options(scipen=999, digits=3)


#### Schätzen der Mehrebenenmodelle ####

#### Variierende Intercepts mit L1 Prädiktoren ####
library(lmerTest) 
mreg1 <- lmer(pol_vertrauen ~ 1 + bildung + 
                responsivitaet + zufr_wirtschaft + soz_vertrauen + 
                (1 | cntry),  
              data=ess)

summary(mreg1)

#Zeigt die Random Effects
ranef(mreg1)

#Zeigt die Fixed Effects
fixef(mreg1)


# Zum Vergleich: das Nullmodell
mreg0 <- lmer(pol_vertrauen ~ 1 + (1 | cntry),  
              data=ess)

summary(mreg0)
summary(mreg1)

# Gütemaße 
library(performance)
r2(mreg1)

model_performance(mreg0)


#### Variierende Intercepts mit L1 und L2 Prädiktoren ####

# Bildungsvariable aggregieren
bildung_agg <- aggregate(list(bildung_agg = ess$bildung), 
                         by=list(cntry=ess$cntry), 
                         FUN=mean, na.rm=T)
bildung_agg
ess <- merge(ess, bildung_agg,
             by="cntry",
             all.x = T)

# Deskriptive Grafik zur Makrovariable "bildung_agg" 
library(ggplot2)
ggplot(ess, aes(x=cntry, y=bildung_agg)) +
  geom_bar(stat="identity") +
  scale_y_continuous(limits=c(-1,1)) +
  theme(axis.text=element_text(size=6))

# Drehen der Makrovariable "c_ticpi_2018" (Korruptionsindex)
ess$korruption <- abs(ess$c_ticpi_2018-100)
# Deskriptive Grafik zur gedrehten Variable "korruption"
ggplot(ess, aes(x=cntry, y=korruption)) +
  geom_bar(stat = "summary", fun="mean") +
  scale_y_continuous(limits=c(0,100)) +
  theme(axis.text=element_text(size=6))



library(lmerTest) 
mreg2 <- lmer(pol_vertrauen ~ 1 + bildung + 
                responsivitaet + zufr_wirtschaft + soz_vertrauen + 
                korruption + bildung_agg +
                (1 | cntry),  
              data=ess)

summary(mreg2)

model_performance(mreg2)

