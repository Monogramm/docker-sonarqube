#!/bin/sh

set -e

echo "Waiting to ensure everything is fully ready for the tests..."
sleep 60

echo "Checking main containers are reachable..."
if ! ping -c 10 -q sonarqube_db ; then
    echo 'SonarQube Database container is not responding!'
    # TODO Display logs to help bug fixing
    echo 'Check the following logs for details:'
    ls -al /opt/sonarqube/logs
    tail -n 100 /opt/sonarqube/logs/*.log
    exit 2
fi

if ! ping -c 10 -q sonarqube ; then
    echo 'SonarQube Main container is not responding!'
    # TODO Display logs to help bug fixing
    echo 'Check the following logs for details:'
    ls -al /opt/sonarqube/logs
    tail -n 100 /opt/sonarqube/logs/*.log
    if grep 'max virtual memory areas vm.max_map_count .* is too low, increase to at least [262144]' /opt/sonarqube/logs/es.log; then
        echo 'Bypass virtual memory error not applied in DockerHub...'
        exit 0
    else
        exit 4
    fi
fi

# XXX Add your own tests
# https://docs.docker.com/docker-hub/builds/automated-testing/
#echo "Executing SonarQube app tests..."
## TODO Test result of tests

# Success
echo 'Docker tests successful'
ls -al /opt/sonarqube/logs
exit 0
