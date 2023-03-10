# Remaniement des données
#
# Note : ce script a déjà été exécuté pour vous. Vous ne devez rien faire ici.
# Il est rerpis pour vous montrer comment les données

# Configuration de l'environnement et chargement des packages
SciViews::R()

# Photosynthèse ---

photo <- read("data/raw/2015-08-Fd_DATA.xls", sheet = 1)
photo <- janitor::clean_names(photo)
# Sauvegarde des données
write$csv(photo, "data/photosynthesis.csv")

# Expression des gènes ---

# Note : pour sélectionner une autre feuille que la première d'un fichier Excel,
# on utilise l'argument sheet =
#gene <- read("data/raw/2015-08-Fd_DATA.xls", sheet = 2)
#gene <- janitor::clean_names(gene)

# Nettoyage de l'environnement
rm(photo)
