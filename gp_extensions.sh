#!/bin/bash

LIST_FILE="gp_ext.list"

function dump {
    echo "Dumping extensions list to $LIST_FILE"

    code --list-extensions > $LIST_FILE

    echo "Done"
}

function install {
    if ! [ -r $LIST_FILE ]; then
        echo "Extensions list file ($LIST_FILE) was not found, aborting"
        exit 1
    fi

    echo "Installing extensions from gp_ext.list"

    pids=""

    for PKG in $(cat ./gp_ext.list); do
       code --install-extension $PKG &
       pids="$pids $!"
    done

    wait $pids

    echo "Install finished"
}


ACTION=${1:-install}
if [ $ACTION = "dump" ]; then
    dump
else
    install
fi

