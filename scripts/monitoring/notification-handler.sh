
DISCORD_WEBHOOK="https://discordapp.com/api/webhooks/1346611512126603284/QtTWV4go7MlX9mDqtHC4lXENmglEIq7JZ7ebhgjzIEqg4FQxEtqY2x_8sfQu2T6j-sut"  


//EMAIL_RECIPIENTS="fatimaamadoudiop@gmail.com"  

# Fonction pour envoyer des notifications
notify() {
    local STATUS=$1
    local MESSAGE=$2
    
    # Notification Discord
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"content\":\"${MESSAGE}\"}" \
        $DISCORD_WEBHOOK
        
    # Notification Email
    //echo "${MESSAGE}" | mail -s "Build Status: ${STATUS}" $EMAIL_RECIPIENTS
}

# Exemple d'utilisation
STATUS="SUCCESS"  # ou "FAILURE"
MESSAGE=":mega: Build ${STATUS} pour le projet **${JOB_NAME}** (#${BUILD_NUMBER}). Détails : [Lien vers les logs](${BUILD_URL})"

# Appel de la fonction notify
notify "$STATUS" "$MESSAGE"