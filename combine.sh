#!/bin/bash

HOST = "172.16.23.125"
NAME = "anuta"

if ["$1" = "atom-agent"]	#Module 1
then
	cd agent-installer 
	mvn install -P release
	mv target/naas-agent-installer.jar /var/www/html/jars/
	cd docker/dockerdeploy/docker/src
	cp -f /var/www/html/jars/naas-agent-installer.jar .
	docker build -t $HOST/$NAME/atom-agent:$2 -f Dockerfile.agent .
	docker push
elif ["$1" = "atom-core"]	#Module 2
then
	cd installer
	mvn installer -P release-agentserver
	mv target/naas-server-installer.jar /var/www/html/jars/
	cd docker/dockerdeploy/docker/src
	cp -f /var/ww/html/jars/naas-server-installer.jar .
	docker build -t $HOST/$NAME/atom-core:$2 -f Dockerfile.core .
	docker push
elif ["$1" = "atom-inventory-mgr"]	#Module 3
then
	cp ~/.m2/repository/org/python/jython-standalone/2.7.0/jython-standalone-2.7.0.jar /var/www/html/jars/
	cd microservices/configparsing
	mvn clean install _DskipTests
	mv web/target/*web-1.0-SNAPSHOT.jar /var/www/html/jars/
	cd ../../extra/ncxignite-*.jar /var/www/html/jars/
	cd docker/dockerdeploy/docker/src
	mv /var/www/html/jars/*web-1.0-SNAPSHOT.jar .
	docker build -t $HOST/$NAME/atom-inventory-mgr:0.1 -f Dockerfile.inventory-mgr .
	docker push
elif ["$1" = "atom-scheduler"]	#Module 4
then
	cd microservices/scheduler
	mvn clean install -DskipTests
	mv target/scheduler-1.0.0-SNAPSHOT.jar /var/www/html/jars/
	cd docker/dockerdeploy/docker/src
	cp -f /var/www/html/jars/scheduler-1.0.0-SNAPSHOT.jar .
	docker build -t $HOST/$NAME/atom-telemetry-engine:0.1 -f Dockerfile .
	docker push
elif ["$1" = "atom-telemetry-engine"]	#Module 5
then
	
	cd microservices/telemetry/src/main/resources/
	cp -f /var/www/html/jars/telemetry-engine-1.0.jar .
	docker build -t $HOST/$NAME/atom-telemetry-engine:0.1 -f Dockerfile .
	docker push
elif ["$1" = "atom-pnp-server"]	#Module 6
then
	cd microservices/pnpserver/src/main/resources/
	cp -f /var/www/html/jars/pnp-server-*.jar .
	docker build -t $HOST/$NAME/atom-pnp-server:0.1 -f Dockerfile .
	docker push
elif ["$1" = "atom-workflow-engine"]	#Module 7
then
	cd microservices/workflow/src/main/resources/
	cp -f /var/www/html/jars/atom-workflow-*.jar .
	docker build -t $HOST/$NAME/atom-workflow-engine:0.1 -f Dockerfile .
	docker push
elif ["$1" = "atom-telemetry-exporter"]	#Module 8
then
	cd microservices/telemetry-kafka-exporter/src/main/resources/
	cp /var/www/html/jars/kafka-exporter*.jar .
	docker build -t $HOST/$NAME/atom-telemetry-exporter:0.1 -f Dockerfile .
	docker push
fi
