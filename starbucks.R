library(dplyr)
library(tidyr)
library(ggplot2)
library(leaflet)
library(highcharter)
library(DT)

starbucks <- read.csv("C:/Users/silverstone/Desktop/starbucks.csv", stringsAsFactors = F)
head(starbucks)

turkey <- starbucks[starbucks$Country == "TR",]
head(turkey)
turkey$City[turkey$City == "Istanbul - Asya"] <- "Istanbul"
turkey$City[turkey$City == "Istanbul - Avrupa"] <- "Istanbul"
turkey$City[turkey$City == "Pendik"] <- "Istanbul"
turkey$City[turkey$City == "Instanbul - Asya"] <- "Istanbul"
turkey$City[turkey$City == "Beyoglu"] <- "Istanbul"
turkey$City[turkey$City == "Yenimahalle Merkez"] <- "Ankara"
turkey$City[turkey$City == "Susurluk"] <- "Balikesir"
turkey$City[turkey$City == "Osmangazi"] <- "Bursa"
turkey$City[turkey$City == "Tepebasi"] <- "Eskisehir"
turkey$City[turkey$City == "Izmit"] <- "Kocaeli"
turkey$City[turkey$City == "Kocaeli (Izmit)"] <- "Kocaeli"
turkey$City[turkey$City == "Mersin (Icel)"] <- "Mersin"
turkey$City[turkey$City == "Mersin Icel"] <- "Mersin"
turkey$City[turkey$City == "Bodrum"] <- "Mugla"
turkey$City[turkey$City == "Afyon"] <- "Afyonkarahisar"



sehirler <- turkey %>% group_by(City) %>% summarise(Toplam = round(n()))


sehir <- turkey %>% group_by(City) %>% summarise(Toplam = n(), 
              Oran = round(Toplam/dim(turkey)[1] * 100, 2)) %>% arrange(desc(Toplam))



datatable(sehir)

hchart(sehir, "treemap", hcaes(x = City, value = Toplam, color = Toplam )) %>%
hc_colorAxis(stops = color_stops(5,colors = c("#039e52", "#00704a", "#024c27"))) %>%
hc_add_theme(hc_theme_google()) %>%
hc_title(text = "Şehirlere göre Starbucks sayıları") %>%
hc_credits(enabled = TRUE, text = "Source: Starbucks Locations Worldwide data from kaggle.com", style = list(fontSize = "10px")) %>%
hc_legend(enabled = TRUE)


leaflet() %>% addTiles() %>% setView(lat=38.8714568, lng =30.752626, zoom= 5) %>% addCircles(lat= turkey$Latitude, lng = turkey$Longitude, color = "#024c27") %>% clearBounds()
SehirHarita
