#!/usr/bin/env bash

export CLEAN_WORKSPACE=$1
export CLEANUP_TOMCAT=$2
export CLEANUP_UNIVERSAL_TAGS=$3

export OPENGROK_WORKSPACE=~/opengrok

if [ "$CLEAN_WORKSPACE" == "y" -o "$CLEAN_WORKSPACE" == "Y" ]; then
    echo "--------------------------------------------------"
    echo "cleaning opengrok workspace: " $OPENGROK_WORKSPACE
    echo "--------------------------------------------------"
    rm -rf $OPENGROK_WORKSPACE
fi

if [ "$CLEANUP_TOMCAT" == "y" -o "$CLEANUP_TOMCAT" == "Y" ]; then
    # uninstall tomcat
    echo "--------------------------------------------------"
    echo "Uninstalling tomcat"
    echo "--------------------------------------------------"
    brew uninstall tomcat
fi

if [ "$CLEANUP_UNIVERSAL_TAGS" == "y" -o "$CLEANUP_UNIVERSAL_TAGS" == "Y" ]; then
    # uninstall universal tags
    echo "----------------------- "
    echo "Uninstalling universal-ctags"
    echo " -----------------------"
    brew uninstall universal-ctags/universal-ctags/universal-ctags
fi

# install tomcat
echo "--------------------------------------------------"
echo "Installing tomcat"
echo "--------------------------------------------------"
brew install tomcat

# install universal tags
echo "----------------------- "
echo "Installing universal-ctags"
echo " -----------------------"
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Create directories for opengrok workspace
mkdir -p $OPENGROK_WORKSPACE/{src,data,dist,etc,log}

# Using latest version of opengrok
wget https://github.com/oracle/opengrok/releases/download/1.7.35/opengrok-1.7.35.tar.gz -P $OPENGROK_WORKSPACE/dist

# extract the tarball file
echo "--------------------------------------------------"
echo "Extracting $OPENGROK_WORKSPACE/dist/opengrok-1.7.35.tar.gz to $OPENGROK_WORKSPACE/dist"
echo "--------------------------------------------------"
tar -C $OPENGROK_WORKSPACE/dist --strip-components=1 -xzf $OPENGROK_WORKSPACE/dist/opengrok-1.7.35.tar.gz

# remove downloaded tar file
rm $OPENGROK_WORKSPACE/dist/opengrok-1.7.35.tar.gz

# Copy logging.properties file to etc folder
cp $OPENGROK_WORKSPACE/dist/doc/logging.properties $OPENGROK_WORKSPACE/etc


# Modify $OPENGROK_WORKSPACE/etc/logging.properties with below
# java.util.logging.FileHandler.pattern = $OPENGROK_WORKSPACE/log/opengrok%g.%u.log

# clone git repos in src folder which you want to add into opengrok code crawler
# Add more git repo as per your requirenment
echo "--------------------------------------------------"
echo "Cloning git repos"
echo "--------------------------------------------------"
echo "git clone https://github.com/trinodb/trino.git $OPENGROK_WORKSPACE/src/trino"
git clone https://github.com/trinodb/trino.git $OPENGROK_WORKSPACE/src/trino

# More details on the above steps mentioned over here https://github.com/oracle/opengrok/wiki/How-to-setup-OpenGrok