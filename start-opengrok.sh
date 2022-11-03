#!/usr/bin/env bash

export OPENGROK_WORKSPACE=~/opengrok

# Modify the tomcat location according to your system's tomcat location
export TOMCAT_HOME=/opt/homebrew/Cellar/tomcat/10.0.23

# copy source.war file into tomcat webapps folder.
cp $OPENGROK_WORKSPACE/dist/lib/source.war $TOMCAT_HOME/libexec/webapps/

# Start the tomcat server now
$TOMCAT_HOME/bin/catalina start

echo "Sleeping 10 seconds to let tomcat server start"
sleep 10
echo "Waking up"

# Execute below command separatly if you have added more git repo in src folder. Make sure the PORT mentioned below is the same where the tomcat server has started.
# Modify tomcat server port at /opt/homebrew/Cellar/tomcat/10.0.23/libexec/conf/server.xml and in below command as well.
java -Djava.util.logging.config.file=$OPENGROK_WORKSPACE/etc/logging.properties -jar $OPENGROK_WORKSPACE/dist/lib/opengrok.jar -c /opt/homebrew/bin/ctags -s $OPENGROK_WORKSPACE/src -d $OPENGROK_WORKSPACE/data -H -P -S -G -W $OPENGROK_WORKSPACE/etc/configuration.xml -U http://localhost:8080/source

# Browse http://localhost:8080/source to see the magic of opengrok

# More details on the above steps mentioned over here https://github.com/oracle/opengrok/wiki/How-to-setup-OpenGrok
