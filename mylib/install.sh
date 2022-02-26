#!/bin/bash -
#title          : install.sh
#description    :
#author         : Piotr Kośka
#date           : 24.02.2018
#version        : v1.0
#usage          :
#notes          :
#bash_version   : 4.4.12
#editor         : visual studio code

#update by koji :2021.11.29
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
        echo -e "${BLUE}WARNNING: ${GREEN}$0 ${BLUE}wymagane są argumenty 3:$NC ${RED}typ_błędu$NC, ${RED}wiadomość$NC"
        exit 1
    fi

    case "$1" in
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
            echo -e "${RED}Zła składniaa ${BLUE}$0$NC ${RED}dozwolone tylko ${RED}ERROR${NC}, ${BLUE}WARNING${NC}, ${GREEN}OK${NC}, INFO"
            ;;
    esac
    #END
}

function log_dir()
{
    if [ -d "./log" ]; then
        echo :"Katalog "$(pwd)"/log istnieje. " | tee -a ./log/log_${currentDate}.log &> /dev/null
    else
        echo :"Katalog "$(pwd)"/log nie istnieje. " | tee -a ./log/log_${currentDate}.log &> /dev/null
        mkdir ./log/

        echo :"Katalog "$(pwd)"/log utworzony. " | tee -a ./log/log_${currentDate}.log &> /dev/null #currentTime ???
    fi
}

function install_pack()
{
    #Varables
    currentDate=$(date +"%F") # Date
    pacman="apt-get"

    #BEGIN
    log_dir
    if [ $# -eq 0 ]; then
        echo "Nie podałeś żadnego pakietu do instalacji" | tee -a ./log/log_${currentDate}.log &> /dev/null
        show_message WARNING "Nie podałeś żadnego pakietu do instalacji"

        exit 1

    else
        sudo $pacman update | tee -a .log/log_${currentDate}.log &> /dev/null
        for install in "$@"
        do
            dpkg -s install &> /dev/null
            if [ $? -eq 0 ]; then
                echo "Pakiet $install jest już zainstalowany. Nie będę go instalował!" | tee -a ./log/log_${currentDate}.log &> /dev/null
                show_message INFO "Pakiet $install jest już zainstalowany"
            else
                echo "Pakiet $install nie jest zainstalowany. Nastąpi jego instalacja" | tee -a ./log/log_${currentDate}.log &> /dev/null
                show_message INFO "Nastąpi instalacja pakietu $install"
                sudo $pacman install $install | tee -a ./log/log_${currentDate}.log &> /dev/null
                    if [ $? -eq 0 ]; then
                        echo "Pakiet $install został poprawnie zainstalowany" | tee -a ./log/log_${currentDate}.log &> /dev/null
                        show_message OK "Pakiet $install został zainstalowany poprawnie"
                    else
                        echo "Problem z instalacją pakietu sprawdź wyżej." | tee -a ./log/log_${currentDate}.log &> /dev/null
                        show_message WARNING "Coś przy instalacji $install poszło nie tak, sprawdź log"
                    fi
                sudo $pacman install -f | tee -a ./log/log_${currentDate}.log &> /dev/null
            fi
        done
        sudo $pacman autoremove
    fi
    # END
}

function install_webmin()
{
    log_dir
    dpkg -s wget &> /dev/null
    if [ $? -eq 0 ]; then
        echo "Pakiet wget zlokalizowany. Nastąpi pobranie webmin." | tee -a ./log/log_${currentDate}.log &> /dev/null
        mkdir ./temp_download
        if [ -d "./temp_download" ]; then
            wget -O ./temp_download/webmin.deb http://www.webmin.com/download/deb/webmin-current.deb | tee -a ./log/log_${currentDate}.log &> /dev/null
        fi
        if [ -e "/temp_downlod/webmin.deb" ]; then
            show_message OK "Pakiet webmin pobrany - przystępuje do instalacji."
            sudo dpkg -i ./temp_download/webmin.deb | tee -a ./log/log_${currentDate}.log &> /dev/null
            sudo apt-get install -f | tee -a ./log/log_${currentDate}.log &> /dev/null
            echo "Webmin zainstalowany" | tee -a ./log/log_${currentDate}.log &> /dev/null
            show_message OK "Pakiet Webmin zainstalowany."
        else
            echo "Plik webmin.deb nie istnieje, plik został źle pobrany - sprawdź swoje łącze internetowe." | tee -a ./log/log_${currentDate}.log &> /dev/null
            show_message ERROR "Webmin nie zainstalowany, pakiet .deb nie zlokalizowany."
        fi
        show_message IFO "Sprzątanie po czynnościach związanych z aktualizacją."
        echo "Sprzątam - katalog ./temp_download" | tee -a ./log/log_${currentDate}.log &> /dev/null
        rm -rf ./temp_download | tee -a ./log/log_${currentDate}.log &> /dev/null 
    fi    
}