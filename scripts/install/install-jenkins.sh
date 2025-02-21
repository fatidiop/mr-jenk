#!/bin/bash

echo "Nettoyage de l'installation précédente..."
docker stop jenkins || true
docker rm jenkins || true

echo "Installation de Jenkins..."

# Création du volume pour les données Jenkins
docker volume create jenkins_home

# Lancement de Jenkins avec des ports différents (8081 au lieu de 8080)
docker run -d \
  --name jenkins \
  -p 8081:8080 \
  -p 50001:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

# Vérification que le conteneur est en cours d'exécution
echo "Vérification du statut de Jenkins..."
if [ "$(docker ps -q -f name=jenkins)" ]; then
    echo "Jenkins est démarré avec succès!"
    
    echo "Attente du démarrage complet de Jenkins..."
    # Attendre que Jenkins soit complètement démarré
    until docker exec jenkins test -f /var/jenkins_home/secrets/initialAdminPassword; do
        echo "En attente de l'initialisation de Jenkins..."
        sleep 5
    done

    echo "Mot de passe initial Jenkins :"
    docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
else
    echo "Erreur : Jenkins n'a pas démarré correctement"
    docker logs jenkins
fi

echo "Jenkins sera accessible sur : http://localhost:8081"