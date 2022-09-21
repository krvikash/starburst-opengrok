# starburst-opengrok

## Overview:
The scripts basically setup the enviornment for opengrok and helps you to search the source code very efficiently.

OpenGrok is a fast and usable source code search and cross reference engine. It helps you search, cross-reference and navigate your source tree. It understands various program file formats and history from many Source Code Management systems. In other words it lets you grok (profoundly understand) source code and is developed in the open, hence the name OpenGrok

| Arguments.                   | Default Value                        |
| ---------------------------- | -----------------                    |
| OS                           | Mac OS                               |
| Worksace root                | Home location (~)                    |
| Cloned git repo              | https://github.com/trinodb/trino.git |

## Usage:

1. Install all pre-requisites file. Execute ```install-opengrok.sh``` script 

| Arguments                    | Default Value |
| ---------------------------- | ------------- |
| 1 (Cleanup Workspace)        | False         |
| 2 (Uninstall tomcat)         | False         |
| 3 (Uninstall universal tags) | False         |

``` 
sh install-opengrok.sh Y Y Y
```

2. Start tomcat server, clone git repo and do indexing on the source code 

```
sh start-opengrok.sh
```

3. Stop tomcat server
```
sh stop-opengrok.sh
```

4. Add more repo in the $OPENGROK_WORKSPACE/src locationa and re-index the source code by running below command. Tomcat server will automatically pick up the latest code after reindex.

```
java -Djava.util.logging.config.file=$OPENGROK_WORKSPACE/etc/logging.properties -jar \
     $OPENGROK_WORKSPACE/dist/lib/opengrok.jar \ 
     -c /opt/homebrew/bin/ctags \
     -s $OPENGROK_WORKSPACE/src \
     -d $OPENGROK_WORKSPACE/data \
     -H -P -S -G -W \ 
     $OPENGROK_WORKSPACE/etc/configuration.xml \
     -U http://localhost:8080/source
```
