#!/bin/bash
<<<<<<< HEAD

=======
	
>>>>>>> 7e773d3956506d25f8f21bcdcdc5756a5717d858
mvn clean install -DskipTests

if [ "$1" = "atom-agent" ]       #Module 1
then
	cd /agent-installer
	mvn install -P release
	mv  target/my-app-1.0-SNAPSHOT.jar  /var/www/html/jars/
elif [ "$1" = "atom-core"]	#module 2
then
	cd /installer
	mvn installer -P release-agentserver
	mv target/naas-server-installer.jar /var/www/html/jars/
elif ["$1" = "atom-inventory-mgr"]	#Module 3
then
	cp -f ~/.m2/repository/org/python/jython-standalone/2.7.0/jython-standalone-2.7.0.jar /var/www/html/jars
	cd microservices/configparsing
	mvn clean install -DskipTests
	mv web/target/*web-1.0-SNAPSHOT.jar /var/www/html/jars/
	cd ../../extra/ncxextension/target
	mv  ncxignite-*.jar /var/www/html/jars/
elif ["$1" = "atom-scheduler"]	#Module 4
then
	cd /microservices/scheduler
	mvn clean install -DskipTests
	mv target/scheduler-1.0.0-SNAPSHOT.jar /var/www/html/jars/
elif ["$1" = "atom-telemetry-engine"]	#Module 5
then
	cd /microservices/telemetry
	mvn clean install -DskipTests
	mv target/telemetry-engine-1.0.jar /var/www/html/jars/
elif ["$1" = "atom-pnp-server"]	#Module 6
then
	cd /microservices/pnpserver
	mvn clean install -DskipTests
	mv target/pnp-server-*.jar /var/www/html/jars/
elif ["$1" = "atom-workflow-engine"]	#Module 7
then
	cd microservices/workflow
	mvn clean install -DskipTests
	mv target/atom-wrkflow-*.jar /var/www/html/jars/
elif ["$1" = "atom-telemetry-exporter"]	#Module 8
then
	cd microservices/telemetry-kafka-exporter
	mvn clean install -DskipTests
	mv target/kafka-exporter*.jar /var/www/html/jars
fi
