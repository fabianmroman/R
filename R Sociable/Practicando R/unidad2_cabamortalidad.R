mortalidad <- read.csv('mortalidad_infantil_caba_2016.csv')
mortalidad
library(tidyverse)
ggplot(mortalidad) +
  geom_col(aes(x = factor(Comuna), y = Tasa2016))
install.packages("sf")
library(sf)
comunas <- st_read('https://bitsandbricks.github.io/data/CABA_comunas.geojson')
comunas
ggplot(comunas) +
  geom_sf()
ggplot(comunas) +
  geom_sf(aes(fill = comunas))
rivadavia <- st_read('https://bitsandbricks.github.io/data/avenida_rivadavia.geojson')
ggplot(comunas) +
  geom_sf(aes(fill = comunas)) +
  geom_sf(data = rivadavia, color = "red")
nueva_columna <- c("Sur", "Norte", "Sur", "Sur", "Sur", "Norte", "Sur", "Sur", "Sur", "Norte", "Norte", "Norte", "Norte", "Norte", "Norte")
nueva_columna
comunas <- mutate(comunas, ubicacion = nueva_columna)
head (comunas)
ggplot(comunas) +
  geom_sf(aes(fill = ubicacion)) +
  geom_sf(data = rivadavia, color = "red")
mortalidad <- mutate(mortalidad, ubicación = nueva_columna)
head(mortalidad)
ggplot(comunas) +
  geom_sf(aes(fill = mortalidad$Tasa2016)) +
  geom_sf(data = rivadavia, color = "red") +
  scale_fill_distiller(palette = "Spectral")
ggplot(mortalidad) +
  geom_col(aes(x = Comuna, y = Tasa2016, fill = ubicación)) +
  labs(title = "Mortalidad infantil en la Ciudad Autónoma de Buenos Aires",
       subtitle = "Año 2016",
       y = "tasa")
comunas_al_sur <- filter(mortalidad, ubicación == "Sur")
comunas_al_norte <- filter(mortalidad, ubicación == "Norte")
mean(comunas_al_sur$Tasa2016) / mean(comunas_al_norte$Tasa2016)
