# Vérifications de seaweed_notebook.qmd
seaweed <- parse_rmd("../../seaweed_notebook.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes seaweed_notebook est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("seaweed_notebook.qmd"))
  # La version compilée HTML du carnet de notes seaweed_notebook est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("seaweed_notebook.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document seaweed_notebook est-elle conservée ?", {
  expect_true(all(c("Introduction", "But", "Matériel et méthodes",
    "Résultats", "Description des données",
    "Variation de la capacité photosynthétique après 60 minutes dans une eau à 20°C",
    "Différences entre Svalbard et Kirkenes",
    "Discussion et conclusions", "Références")
    %in% (rmd_node_sections(seaweed) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes seaweed_notebook ne sont pas
  # toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "import", "desccomment", "select1", "pivot1",
    "plot1", "tab1", "test1achoice", "test1ahypo", "test1a", "test1acomment",
    "test1bchoice", "test1bhypo", "test1b", "test1bcomment", "test1abcomment",
    "select2", "plot2", "tab2", "test2achoice", "test2ahypo", "test2a",
    "test2acomment", "test2bchoice", "test2bhypo", "test2b", "test2bcomment",
    "test2abcomment", "power2")
    %in% rmd_node_label(seaweed)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent dans
  # seaweed_notebook.qmd
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(seaweed))))
  # Un ou plusieurs labels de chunks sont dupliqués dans seaweed_notebook.qmd
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété dans seaweed_ca ?", {
  expect_true(seaweed[[1]]$author != "___")
  expect_true(!grepl("__", seaweed[[1]]$author))
  expect_true(grepl("^[^_]....+", seaweed[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", seaweed[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", seaweed[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunk 'import' : importation des données `photo` depuis `data`", {
  expect_true(is_identical_to_ref("import", "names"))
  # Les colonnes dans le tableau `photo` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct.

  expect_true(is_identical_to_ref("import", "classes"))
  # La nature des variables (classe) dans le tableau `photo` est incorrecte
  # Vérifiez le chunk d'importation des données `import`.

  expect_true(is_identical_to_ref("import", "nrow"))
  # Le nombre de lignes dans le tableau `photo` est incorrect
  # Vérifiez le chunk d'importation des données `import`.
})

test_that("Chunks 'select1', 'pivot1' : remaniement des données pour la question #1", {
  expect_true(is_identical_to_ref("select1", "names"))
  # Les colonnes dans le tableau `photo2` ne sont pas celles attendues
  # Vérifiez votre code au chunk `select1`.

  expect_true(is_identical_to_ref("select1", "classes"))
  # La nature des variables (classe) dans le tableau `photo2` est incorrecte
  # Vérifiez votre code au chunk `select1`.

  expect_true(is_identical_to_ref("select1", "nrow"))
  # Le nombre de lignes dans le tableau `photo2` est incorrect
  # Vérifiez votre code au chunk `select1`.

  expect_true(is_identical_to_ref("pivot1", "names"))
  # Les colonnes dans le tableau `photo3` ne sont pas celles attendues
  # Vérifiez votre code au chunk `pivot1`.

  expect_true(is_identical_to_ref("pivot1", "classes"))
  # La nature des variables (classe) dans le tableau `photo3` est incorrecte
  # Vérifiez votre code au chunk `pivot1`.

  expect_true(is_identical_to_ref("pivot1", "nrow"))
  # Le nombre de lignes dans le tableau `photo3` est incorrect
  # Vérifiez votre code au chunk `pivot1`.
})

test_that("Chunks 'plot1', 'tab1' : description des données pour la question #1", {
  expect_true(is_identical_to_ref("plot1"))
  # Le graphique produit par le chunk 'plot1' n'est pas celui attendu.
  # Vérifiez le graphique réalisé qui doit être un nuage de points avec la
  # bissectrice.

  expect_true(is_identical_to_ref("tab1", "names"))
  # Les colonnes dans le tableau `photo3_tab` ne sont pas celles attendues
  # Vérifiez votre code au chunk `tab1`.

  expect_true(is_identical_to_ref("tab1", "classes"))
  # La nature des variables (classe) dans le tableau `photo3_tab` est incorrecte
  # Vérifiez votre code au chunk `tab1`.

  expect_true(is_identical_to_ref("tab1", "nrow"))
  # Le nombre de lignes dans le tableau `photo3_tab` est incorrect
  # Vérifiez votre code au chunk `tab1`.
})

test_that("Chunks 'test1achoice', 'test1ahypo', 'test1a', 'test1acomment' : Test 1a", {
  expect_true(is_identical_to_ref("test1achoice"))
  # La spécification du test1a est incorrecte dans le chunk 'test1achoice'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test1ahypo"))
  # La spécification des hypothèses du test1a est incorrecte dans le chunk
  # 'test1achypo'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test1a"))
  # Le test dans le chunk 'test1a' n'est pas celui attendu.
  # Vérifiez votre code dans le chunk 'test1a'.

  expect_true(is_identical_to_ref("test1acomment"))
  # L'interprétation du test 1a est (partiellement) fausse dans le chunk
  # 'test1acomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'test1bchoice', 'test1bhypo', 'test1b', 'test1bcomment' : Test 1b", {
  expect_true(is_identical_to_ref("test1bchoice"))
  # La spécification du test1b est incorrecte dans le chunk 'test1bchoice'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test1bhypo"))
  # La spécification des hypothèses du test1a est incorrecte dans le chunk
  # 'test1bchypo'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test1b"))
  # Le test dans le chunk 'test1b' n'est pas celui attendu.
  # Vérifiez votre code dans le chunk 'test1b'.

  expect_true(is_identical_to_ref("test1bcomment"))
  # L'interprétation du test1b est (partiellement) fausse dans le chunk
  # 'test1bcomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'test1abcomment' : Comparaison des tests 1a et 1b", {
  expect_true(is_identical_to_ref("test1abcomment"))
  # La comparaison des tests 1a et 1b est (partiellement) fausse dans le chunk
  # 'test1abcomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'select2' : remaniement des données pour la question #2", {
  expect_true(is_identical_to_ref("select2", "names"))
  # Les colonnes dans le tableau `photo4` ne sont pas celles attendues
  # Vérifiez votre code au chunk `select2`.

  expect_true(is_identical_to_ref("select2", "classes"))
  # La nature des variables (classe) dans le tableau `photo4` est incorrecte
  # Vérifiez votre code au chunk `select2`.

  expect_true(is_identical_to_ref("select2", "nrow"))
  # Le nombre de lignes dans le tableau `photo4` est incorrect
  # Vérifiez votre code au chunk `select2`.
})

test_that("Chunks 'plot2', 'tab2' : description des données pour la question #2", {
  expect_true(is_identical_to_ref("plot2"))
  # Le graphique produit par le chunk 'plot2' n'est pas celui attendu.
  # Vérifiez le graphique réalisé qui doit être une boite de dispersion avec les
  # observations superposées.

  expect_true(is_identical_to_ref("tab2", "names"))
  # Les colonnes dans le tableau `photo4_tab` ne sont pas celles attendues
  # Vérifiez votre code au chunk `tab2`.

  expect_true(is_identical_to_ref("tab2", "classes"))
  # La nature des variables (classe) dans le tableau `photo4_tab` est incorrecte
  # Vérifiez votre code au chunk `tab2`.

  expect_true(is_identical_to_ref("tab2", "nrow"))
  # Le nombre de lignes dans le tableau `photo4_tab` est incorrect
  # Vérifiez votre code au chunk `tab2`.
})

test_that("Chunks 'test2achoice', 'test2ahypo', 'test2a', 'test2acomment' : Test 2a", {
  expect_true(is_identical_to_ref("test2achoice"))
  # La spécification du test2a est incorrecte dans le chunk 'test2achoice'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test2ahypo"))
  # La spécification des hypothèses du test1a est incorrecte dans le chunk
  # 'test2ahypo'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test2a"))
  # Le test dans le chunk 'test2a' n'est pas celui attendu.
  # Vérifiez votre code dans le chunk 'test2a'.

  expect_true(is_identical_to_ref("test2acomment"))
  # L'interprétation du test 1a est (partiellement) fausse dans le chunk
  # 'test2acomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'test2bchoice', 'test2bhypo', 'test2b', 'test2bcomment' : Test 2b", {
  expect_true(is_identical_to_ref("test2bchoice"))
  # La spécification du test2b est incorrecte dans le chunk 'test2bchoice'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test2bhypo"))
  # La spécification des hypothèses du test1a est incorrecte dans le chunk
  # 'test2bchypo'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !

  expect_true(is_identical_to_ref("test2b"))
  # Le test dans le chunk 'test2b' n'est pas celui attendu.
  # Vérifiez votre code dans le chunk 'test2b'.

  expect_true(is_identical_to_ref("test2bcomment"))
  # L'interprétation du test2b est (partiellement) fausse dans le chunk
  # 'test2bcomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunk 'test2abcomment' : Comparaison des tests 2a et 2b", {
  expect_true(is_identical_to_ref("test2abcomment"))
  # La comparaison des tests 2a et 2b est (partiellement) fausse dans le chunk
  # 'test2abcomment'
  # Vous devez cochez les phrases qui décrivent les graphiques et la table d'un
  # 'x' entre les crochets [] -> [x]. Ensuite, vous devez recompiler la version
  # HTML du bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les
  # résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})


test_that("La partie discussion et conclusions est-elle remplie ?", {
  expect_true(!(rmd_select(seaweed, by_section("Discussion et conclusions")) |>
      as_document() |> grepl("- +\\.\\.\\.", x = _) |> any()))
  # La discussion et les conclusions ne sont pas faites
  # Remplacez les items "- " par vos phrases de commentaires
  # libres (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})
