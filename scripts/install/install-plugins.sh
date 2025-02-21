#!/bin/bash

# Liste des plugins essentiels
PLUGINS=(
  "git"
  "pipeline-model-definition"
  "workflow-aggregator"
  "docker-workflow"
  "credentials-binding"
  "email-ext"
  "slack"
)
EOF

chmod +x scripts/install/install-plugins.sh

# Installation des plugins
for plugin in "${PLUGINS[@]}"
do
  jenkins-plugin-cli --plugins "$plugin"
done