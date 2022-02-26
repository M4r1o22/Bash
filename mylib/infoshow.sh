#!/bin/bash

#title          : infoshow.sh
#description    :
#author         : Piotr Kośka
#date           : 24.02.2018
#version        : v1.0
#usage          :
#notes          :
#bash_version   : 4.4.12
#editor         : visual studio code

#update by koji :2021.12.16
#===========================================

function show_message()
{
    # Varables
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    BLUE="\033[0;34m"
    NC="\033[0m"

    currentTime=$(date +"%T") #Time

    #BEGIN

    if [ $# -lt 2 ]; then
        echo -e "${BLUE}WARNING: ${GREEN}$0 ${BLUE}wymagane są argumenty 2:$NC ${RED}typ_błędu$NC, ${RED}wiadomość$NC"
        exit 1
    fi

    case "$1" in
    #ERROR "Twoj wiadomość"
    #WARNING "Twoja wiadomość"
    #OK "Twoja wiadomość"
    #INFO "Twoja wiadomość"

        [eE] | [eE][rR][rR][oO][rR] )
            echo -e "${RED}${1}$NC: $2"
            ;;
        [wW] | [wW][aA][rR][nN][iI][nN][gG] )
            echo -e "${BLUE}${1}$NC: $2"
            ;;
        [oO] | [oO][kK] )
            echo -e "${GREEN}${1}$NC: $2"
            ;;
        [iI] | [iI][nN][fF][oO] )
            echo -e "INFO: $2"
            ;;
        *)
            echo -e "${RED}Zła składnia ${BLUE}$0$NC ${RED}dozwolone tylko ${RED}ERROR${NC}, ${BLUE}WARNING${NC}, ${GREEN}OK${NC}, INFO"
            ;;
    esac
    #END
}