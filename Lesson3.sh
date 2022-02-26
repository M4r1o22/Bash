#!/bin/bash

#Zadanie 1. Informacje o systemie
#Zadanie 2. Lista użytkowników
#Zadanie 3. Lista grup
#Zadanie 4. Interfejsy sieciowe
#Zadanie 5. Informacje o dysku

#Dodatkowe: Przeróbmy zadanie drugie tak aby do instalacji paietów wykorzystać attidue

#Script
#Solution

currentDate=$(date +"%F") #data
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m"

function mysystem_info()
{
    if [ $# -eq 0 ]; then
        echo -e "${BLUE}WARNING - Nie podałeś żadnego argumentu dla funkcji.$NC" | tee -a log_3_$currentDate.log
        echo "Nasze argumenty: kernel, ostype, distro, platform"
        exit 1
    fi

    for myargs in "$@"
    do
        # Kernel version
        if [ $myargs = 'kernel' ]; then
            echo -e "${GREEN}Twoja wersja kernela to: "$(uname -r)"$NC"
        fi
        # OS type
        if [ $myargs = 'ostype' ]; then
            echo -e "${GREEN}Twoja wersja OS type to: "$(uname -s)"$NC"
        fi
        # Distro version
        if [ $myargs = 'distro' ]; then
            echo -e "${GREEN}Twoja wersja distro to: "$(cat /proc/sys/kernel/version)"$NC"
        fi
        # Platform
        if [ $myargs = 'platform' ]; then
            echo -e "${GREEN}Twoja wersja platformy to: "$(uname -m)"$NC"
        fi

    done
}

function user_list()
{
    if [ $# -lt 1 ]; then
        echo -e "${BLUE}WARNING - Użyj - ${GREEN}$0 ${RED}parametru$NC"
        echo -e "${BLUE}Dostępne parametry to:$NC"
        echo -e "${GREEN}home$NC - Zwraca użytkowwników ze ścieżką /home"
        echo -e "${GREEN}uid$NC - Zwraca użytkowników z UID > 1000"
        echo -e "${GREEN}homeuid$NC - Zwraca użytkowników ze ścieżką /home i UID > 1000"
        echo -e "${GREEN}bash$NC - Zwraca użytkowników z powłoką /bin/bash"
    fi

    case "$1" in
        home)
            echo -e "${GREEN}Lista użytkowników: $NC"
            awk -F: '/\/home/ {printf "%s:%s\n",$1,$3}' /etc/passwd
            ;;
        uid)
            echo -e "${GREEN}Lista użytkowników: $NC"
            awk -F: '($3 >= 1000) {printf "%s:%s\n",$1,$3}' /etc/passwd
            ;;
        homeuid)
            echo -e "${GREEN}Lista użytkowników: $NC"
            awk -F: '/\/home/ && ($3 >= 1000) {printf "%s:%s\n",$1,$3}' /etc/passwd
            ;;
        bash)
            echo -e "${GREEN}Lista użytkowników: $NC"
            cat /etc/passwd | grep "/bin/bash" | cut -d: -f1
            ;;
        *)
            echo -n "Chcesz wyświetlić listę wszystkich użytkowników [tak czy nie]:"
            read tnie
            case "$tnie" in
                [tT] | [tT][aA][kK] )
                    echo -e "${GREEN}Lista użytkowników: $NC"
                    cut -d: -f1 /etc/passwd
                    ;;
                [nN] | [nN][iI][eE] )
                    echo -e "${BLUE}Pa Pa Pa$NC"
                    ;;
            esac
            ;;
    esac
}

function group_list()
{
    case "$1" in
        cut)
            echo -e "${GREEN}Lista grup:$NC"
            cut -d: -f1 /etc/group
            ;;
        awk)
            echo -e "${GREEN}Lista grup:$NC"
            awk -F: '{print $1}' /etc/group
            ;;
        *)
            echo -e "${BLUE}Podałeś zły parametr.${NC} Nasze parametry to: ${RED}cut${NC}, ${RED}awk${NC}."
            ;;    
    esac
}
function net_interfaces()
{
    case "$1" in
        inet)
            echo -e "${GREEN}Nasze interfejsy sieciowe:$NC"
            ip link show
            ;;
        stat)
            echo -e "${GREEN}Nazwy interfejsów ze sttusem UP/DOWN:$NC"
            ip -o link show | awk '{print $2,$9}'
            ;;
        iname)
            echo -e "${GREEN}Nazwy interfejsów:"
            ip -o link show | awk -F: '{print $2}'
            ;;
        kerneli)
            echo -e "${GREEN}Lista interfejsów sieciowych widziana w kernel tabel:$NC"
            netstat -i
            ;;
        iadress)
            echo -e "${GREEN}Lista interfejsów z IPv4 i IPv6:$NC"
            for i in $(ip ntable | grep dev | sort -u | awk '{print $2}') ; do echo "Interfejs sieciowy: "$i; ifconfig $i | grep inet | sed -e "s/\<inet\>/IPv4:/g" | sed -e "s/\<inet\>/IPv6:/g" | awk 'BEGIN{OFS="\t"}{print $1,$2}' ; done
            ;;
        ifls)
            echo -e "${GREEN}Lista urządzeń sieciowych i ich nazwy (interfejsy):$NC"
            ;;
        *)
            echo -e "{$BLUE}Podałeś zły argument/parametr skrytpu:${NC} poprawne to ${RED}inet${NC} ${RED}stat${NC} ${RED}iname${NC} ${RED}kerneli${NC} ${RED}iadress${NC} ${RED}ifls${NC}"
            ;;

    esac
}

function disk_info()
{
    if [ $# -eq 0 ]; then
        df -h
        exit 0
    fi

    if [ $1 = 'total' ]; then
        df -h --$1
    fi
}
function main()
{
    #mysystem_info $1
    #user_list $1
    #group_list $1
    #net_interfaces $1
    disk_info $1
}

main $1