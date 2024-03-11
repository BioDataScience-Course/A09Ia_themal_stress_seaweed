# Remaniement des données
#
# Note : ce script a déjà été exécuté pour vous. Vous ne devez rien faire ici.
# Il est repris pour vous montrer comment les données ont été préparées

# Configuration de l'environnement et chargement des packages
SciViews::R()


# Photosynthèse -----------------------------------------------------------

photo <- read("data/raw/2015-08-Fd_DATA.xls", sheet = 1)
photo <- janitor::clean_names(photo)

# We consider a missing observation for pi_abs in line 10 here
photo$pi_abs[10] <- NA
photo$fv_fm[10] <- NA

# Labels et unités
photo <- labelise(
  label = list(
    duration = "Durée",
    temperature = "Température",
    population = "Population",
    individual = "Individu",
    pi_abs = "Indice de performance photosynthétique",
    fv_fm = "Rendement quantique maximal"
  ),
  units = list(
    duration = "min",
    temperature = "°C"
  )
)

# Sauvegarde des données
write$rds(photo, "data/photosynthesis.rds")


# Expression des gènes ----------------------------------------------------

# Note : pour sélectionner une autre feuille que la première d'un fichier Excel,
# on utilise l'argument sheet = (pas fait ici -> code en commentaire)
#gene <- read("data/raw/2015-08-Fd_DATA.xls", sheet = 2)
#gene <- janitor::clean_names(gene)

# Nettoyage de l'environnement
rm(photo)
