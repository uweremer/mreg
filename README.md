![](https://www.r-project.org/logo/Rlogo.svg)

Vollständiges Script auch online auf der github.io Seite: https://uweremer.github.io/mreg/

# Mehrebenenregression mit R

Dies ist das Skript zur *Videoserie Mehrebenenregression mit R*, die für die Stelle Quantitatvie Methoden der [FernUni Hagen](https://www.fernuni-hagen.de/) entstanden ist.

Diese Videoserie besteht aus sechs aufeinander aufbauenden Teilen:

-   Teil 1: Was ist eine Mehrebenenregression? \[[Video](https://video.fernuni-hagen.de/Play/6076)\] 
-   Teil 2: Wann ist eine Mehrebenenregression angebracht? \[ [Video](https://video.fernuni-hagen.de/Play/6077)\]
-   Teil 3: Wie werden die Daten für eine Mehrebenregression vorbereitet? \[ [Video](https://video.fernuni-hagen.de/Play/6078)\]
-   Teil 4: Wie schätzt man eine Mehrebenenregression in R? \[[Video](https://video.fernuni-hagen.de/Play/6089)\]
-   Teil 5: Wie schätzt man variierende Slopes und Cross-Level Interaktionen? \[[Video](https://video.fernuni-hagen.de/Play/6147)\]
-   Teil 6: Wie lassen sich die Ergebnisse einer Mehrebenregression berichten? \[[Video](https://video.fernuni-hagen.de/Play/6148)\]

Zu allen Videos gibt es auf dieser Seite den R Code sowie das Skript. 


## Die Kurzfassung

Die Mehrebenenregression ist ein multivariates statistisches Verfahren zur Analyse von Daten, die eine hierarchische Struktur mit mehreren (mindestens zwei) Ebenen aufweisen:

Zum Beispiel:

-   Befragte in Ländern / Gemeinden / Oragnisationen
-   Schüler:innen in Klassen in Schulen
-   Länder in Jahren
-   etc.

Immer wenn die übergeordnete Ebene für ausreichend große Varianz in den Daten sorgt, ist eine einfache Regression ungeeignet. Zum einen werden die Standardfehler unterschätzt. Die Mehrebenenregression schätzt diese korrekt. Außerdem erlaubt es die Mehrebenenregression, die komplexe Datenstruktur elegant zu modellieren und in greifbaren *quantities of interest* auszudrücken.

Mit der Mehrebenenregression kann man die welche Wechselwirkungen zwischen den unterschidlichen Ebenen besser modellieren und statistisch prüfen, ob diese Unterschiede tatsöächlich bedeutsam sind.

## Voraussetzungen

Damit Sie den Inhalten folgen können, sollten Sie Vorkenntnisse zur linearen OLS Regression haben, sowie Grundlagen in R beherrschen. Ideal wäre es, wenn Sie auch schon einen Lehrbuchtext zur Mehrebenenregression gelesen haben. Eine Auswahl an geeigneten Texten finden Sie am weiter unten auf dieser Seite.

## Zielgruppe

BA oder MA Studierende aus Wirtschafts- und Sozialwissenschaften, Psychologie oder Digital Humanities, mit Vorkenntnissen in quantitativen Methoden (Grundlagen in R und in multivariater Statistik, z.B. OLS Regression).

## Literatur zum Einstieg

-   Tausendpfund, Markus (2020): Mehrebenenanalyse. In: ebd. (Hrsg.): Fortgeschrittene Analyseverfahren in den Sozialwissenschaften. Grundwissen Politik. Springer VS, Wiesbaden. <https://doi.org/10.1007/978-3-658-30237-5_5>
-   Pötschke, Manuela. (2020). Mehrebenenmodelle. In: Wagemann, Claudius; Goerres, Achim; Siewert, Markus B. (Hrsg.): Handbuch Methoden der Politikwissenschaft. Springer VS, Wiesbaden. <https://doi.org/10.1007/978-3-658-16936-7_29>
-   Gellman, Andrew; Hill, Jennifer (2009): Data-Analysis Using regression and Multilevel/Hierachical Models. Cambridge: Cambridge University Press. Kap. 12 & 13. <https://doi.org/10.1017/CBO9780511790942>
-   Fox, John 2016: Applied Regression Analysis and Generalized Linear Models. Sage. Chp 23 Linear Mixed-Effects Models for Hierarchical and Longitudinal Data 700-742.