#!/bin/sh

set -e

echo "Waiting to ensure everything is fully ready for the tests..."
sleep 300

echo "Checking main containers are reachable..."
if ! ping -c 10 -q sonarqube_db ; then
    echo 'SonarQube Database container is not responding!'
    echo 'Check the following logs for details:'
    ls -al /opt/sonarqube/logs
    tail -n 100 /opt/sonarqube/logs/*.log
    exit 2
fi

if ! ping -c 10 -q sonarqube ; then
    echo 'SonarQube Main container is not responding!'
    echo 'Check the following logs for details:'
    ls -al /opt/sonarqube/logs
    tail -n 100 /opt/sonarqube/logs/*.log
    # FIXME vm.max_map_count not applied in Dockerhub
    if grep 'max virtual memory areas vm.max_map_count .* is too low, increase to at least .*' /opt/sonarqube/logs/es.log; then
        echo 'Bypass virtual memory error not applied in DockerHub...'
        exit 0
    else
        exit 4
    fi
fi

# https://docs.docker.com/docker-hub/builds/automated-testing/
#echo "Test SonarQube Healthcheck..."
curl http://sonarqube:9000/api/system/status

# Success
echo 'Docker tests successful. Check logs for details:'
tail /opt/sonarqube/logs/*
exit 0
