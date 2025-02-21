# scripts/pipeline/test-failure-simulation.sh
#!/bin/bash

# Simuler différents types d'erreurs
case "$1" in
  "build")
    echo "Simulating build failure"
    exit 1
    ;;
  "test")
    echo "Simulating test failure"
    echo "<testsuite failures='1'></testsuite>" > test-failure.xml
    exit 1
    ;;
  "deploy")
    echo "Simulating deployment failure"
    exit 1
    ;;
esac