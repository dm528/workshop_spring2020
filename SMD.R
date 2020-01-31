library(dismo)
library(maptools)
library(rgdal)
library(xlsx)
data98<-read.xlsx(file.choose(),2)
data14<-read.xlsx(file.choose(),3)
max.lat = ceiling(max(c(data98$y,data14$Y)))
min.lat = floor(min(c(data98$y,data14$Y)))
min.lon = floor(min(c(data98$X,data14$X)))
max.lon = ceiling(max(c(data98$X,data14$X)))
geographic.extent <- extent(x = c(min.lon, max.lon, min.lat, max.lat))
bioclim.data <- getData(name = "worldclim",
                                               var = "bio",
                                               res = 2.5)
bioclim.data <- crop(x = bioclim.data, y = geographic.extent)
data(wrld_simpl)
bc.model <- bioclim(x = bioclim.data, p = data98)
predict.presence98 <- dismo::predict(object = bc.model, x = bioclim.data, ext = geographic.extent)
plot(wrld_simpl,
     xlim = c(min.lon, max.lon),
     ylim = c(min.lat, max.lat),
     axes = TRUE,
     col = "grey95", main="Predictive Map for Bald Eagle Nests based on 1998 data")
plot(predict.presence98, add = TRUE)
plot(wrld_simpl, add = TRUE, border = "grey5")

bc.model14 <- bioclim(x = bioclim.data, p = data14)
predict.presence14 <- dismo::predict(object = bc.model14, x = bioclim.data, ext = geographic.extent)
plot(wrld_simpl,
      xlim = c(min.lon, max.lon),
       ylim = c(min.lat, max.lat),
       axes = TRUE,
       col = "grey95", main="Predictive Map for Bald Eagle Nests based on 2014 data")
plot(predict.presence14, add = TRUE)
plot(wrld_simpl, add = TRUE, border = "grey5")