# Videoserie Mehrebenenregression mit R 
# Teil 3/6 
# Wie schätzt man eine Mehrebenenregression in R?
# Dr. Uwe Remer



#### Operationalisierung ####

# Importieren des Datensatz
library(foreign)
ess <- read.spss("./Daten/ESS9e02.sav", 
                 use.value.labels = FALSE,
                 to.data.frame = TRUE,
                 reencode = TRUE)



# Operationalisierung der abh. Variable 
# "Politisches Vertrauen"
# Mittelwertindex aus drei Items:
idx_vars <- c("trstprl","trstplt","trstprt")
ess$pol_vertrauen <- rowMeans(ess[,idx_vars], 
                              na.rm = F)
#table(ess$pol_vertrauen, useNA = "always")
library(DescTools)
#Desc(ess$pol_vertrauen)

# Operationalisierung der unabh. Variable 
# Bildung
ess$bildung <- ess$eisced 

# NAs definieren:
# `0` und `55` auf `NA` setzten
ess$bildung[ess$bildung %in% c(0,55)] <- NA

#Desc(ess$bildung)

# Operationalisierung der unabh. Variable 
# Wahrgenommene politische Responsivität 
# Mittelwertindex aus zwei Items 

idx_vars <- c("psppsgva","psppipla")
ess$responsivitaet <- rowMeans(ess[,idx_vars], 
                               na.rm = F)

# Wertebreich rekodieren auf 0 bis 4
ess$responsivitaet <- ess$responsivitaet - 1

#Desc(ess$responsivitaet)

# Operationalisierung der unabh. Variable 
# "Zufriedenheit Wirtschaftslage"

ess$zufr_wirtschaft <- ess$stfeco
#Desc(ess$zufr_wirtschaft)

# Operationalisierung der unabh. Variable 
# Soziales Vertrauen

ess$soz_vertrauen <- ess$ppltrst
#Desc(ess$soz_vertrauen)

# Einlesen Makrodaten einlesen und mit merge() hinzuspielen
ess_macro <- read.table("./Daten/ess2018_macro.csv",
                        sep=";", header=T)
head(ess_macro)

ess_micro <- ess
ess <- merge(ess_micro, ess_macro, # Die beiden Datensätze die zusammengespielt werden
             by = "cntry", # Die Schlüsselvariable
             all.x = T) # Das alle Fälle des x-Datensatzes (des erstgenannten) behalten werden

# Missing Values ausschließen
variablen_im_modell <- c("pol_vertrauen",
                         "bildung",      
                         "responsivitaet",                         
                         "zufr_wirtschaft",
                         "soz_vertrauen", 
                         "cntry",
                         "c_ticpi_2018")
ess <- na.omit(ess[,variablen_im_modell])


# Zentrieren der Ebene 1 x-Variablen
# Diese sind an 2. bis 5. und 7. Stelle im Datensatz
#names(ess)
#ess[,c(2:5)]
#scale(ess[,c(2:5)], scale=F)
ess_centered <- as.data.frame(scale(ess[,c(2:5)], scale=F))
ess[,c(2:5)] <- ess_centered


#### Schätzen der Mehrebenenmodelle ####

#### Variierende Intercepts mit L1 ####
library(lmerTest) 
mreg1 <- lmer(pol_vertrauen ~ 1 + bildung + 
                responsivitaet + zufr_wirtschaft + soz_vertrauen + 
                (1 | cntry),  
              data=ess)

summary(mreg1)

ranef(mreg1)

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
library(lmerTest) 
mreg2 <- lmer(pol_vertrauen ~ 1 + bildung + 
                responsivitaet + zufr_wirtschaft + soz_vertrauen + 
                korruption + bildung_agg +
                (1 | cntry),  
              data=ess)

summary(mreg2)

model_performance(mreg2)

