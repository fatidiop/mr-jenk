#!/bin/bash

# Configuration
LOGFILE="/Projets/mr-jenk/build.log"  # Chemin vers le fichier de log du build
SLACK_WEBHOOK="https://hooks.slack.com/services/xxx"  # Webhook Slack (optionnel)


# Fonction pour envoyer des notifications
notify() {
    local STATUS=$1
    local MESSAGE=$2
    
    # Notification Slack (optionnel)
    if [ -n "$SLACK_WEBHOOK" ]; then
        curl -X POST -H 'Content-type: application/json' \
            --data "{\"text\":\"${MESSAGE}\"}" \
            $SLACK_WEBHOOK
    fi

    
}

# Vérifier le statut du build
check_build_status() {
    if [ ! -f "$LOGFILE" ]; then
        echo "Erreur : Le fichier de log $LOGFILE n'existe pas."
        exit 1
    fi

    # Rechercher des mots-clés dans le fichier de log
    if grep -q "BUILD SUCCESS" "$LOGFILE"; then
        STATUS="SUCCESS"
        MESSAGE=":tada: Le build a réussi ! Détails : [Lien vers les logs](#)"
    elif grep -q "BUILD FAILURE" "$LOGFILE"; then
        STATUS="FAILURE"
        MESSAGE=":x: Le build a échoué. Détails : [Lien vers les logs](#)"
    else
        STATUS="UNKNOWN"
        MESSAGE=":warning: Le statut du build est inconnu. Détails : [Lien vers les logs](#)"
    fi

    # Afficher le statut dans la console
    echo "Statut du build : ${STATUS}"

    # Envoyer une notification
    notify "$STATUS" "$MESSAGE"
}

# Exécuter la vérification du statut
check_build_status