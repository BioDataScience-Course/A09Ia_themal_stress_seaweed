# Remaniement des données

# Packages
SciViews::R()

# Photosynthèse ---
photo <- read("data/data_raw/2015-08-Fd_DATA.xls", sheet = 1)
photo <- janitor::clean_names(photo)

# Sauvegarde des données
write$csv(photo, "data/photosynthesis.csv")

# gène ---
## Note : Observez l'instruction suivante.
## Pour sélectionner la seconde feuille d'un fichiers xls, on utilise l'argument sheet =
#gene <- read("data/data_raw/2015-08-Fd_DATA.xls", sheet = 2)
#gene <- janitor::clean_names(gene)

rm(photo)
