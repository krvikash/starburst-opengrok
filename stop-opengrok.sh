#!/usr/bin/env bash

export OPENGROK_WORKSPACE=~/opengrok

# Modify the tomcat location according to your system's tomcat location
export TOMCAT_HOME=/opt/homebrew/Cellar/tomcat/10.0.23

# Start the tomcat server now
$TOMCAT_HOME/bin/catalina stop