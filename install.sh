#!/usr/bin/env bash

install () {
    cp ${BASH_SOURCE%/*}/$1/Makefile .
    cp -a ${BASH_SOURCE%/*}/$1/makefiles .
    rm -rf ${BASH_SOURCE%/*}
}

echo 'Select environment:'

PS3=': '
options=("Symfony" "ReactJs" "Cancel")
select opt in "${options[@]}"
do
    case $opt in
        "Symfony")
            install symfony
            break
            ;;
        "ReactJs")
            install react
            break
            ;;
        "Cancel")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
