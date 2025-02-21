# scripts/monitoring/notification-handler.sh
#!/bin/bash

# Configuration Slack
SLACK_WEBHOOK="https://hooks.slack.com/services/xxx"

# Configuration Email
EMAIL_RECIPIENTS="team@company.com"

notify() {
    local STATUS=$1
    local MESSAGE=$2
    
    # Notification Slack
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"${MESSAGE}\"}" \
        $SLACK_WEBHOOK
        
    # Notification Email
    echo "${MESSAGE}" | mail -s "Build Status: ${STATUS}" $EMAIL_RECIPIENTS
}