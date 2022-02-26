#!/bin/bash

function show_menu()
{
    options="\"Dodaj użytkownika\" \"Pokaż użytkowników\" \"Wyjście\""
    PS3='Wybierz opcję: '

    eval set $options

    select option in "$@"
    do
        case "$option" in
            "Dodaj użytkownika" )
                read -p "Podaj swoje imię: " name
                read -p "Podaj swoje nazwisko: " surname
                create_user_now $name $surname
                ;;
            "Pokaż użytkowników" )
                echo "Lista aktualnych użytkownników:"
                awk -F: '($3 >= 1000) {printf "%s:\n",$1}' /etc/passwd
                read -n 1 -s -r -p "Nciśnij dowolny klawisz aby kontynuować..."
                ;;
            "Wyjście" )
                exit 0
                ;;
        esac
    done
    echo "Wyjście ze skryptu"
}

function create_user_now()
{
    #sprawdzanie ile argumentów zostało przekazanych do funkcji.
    if [ $# -eq 2 ]; then
    # imię małymi literami
    user_name=$(echo $1 | tr [:upper:] [:lower:])
    #nazwisko małymi
    user_surname=$(echo $2 | tr [:upper:] [:lower:])
    #wydobywamy pierwszą literę z imienia
    oneletter=$(echo $user_name | cut -c 1)
    #Tworzymy konto
    account=$oneletter$user_surname
    else
    #Jeden argument, dane z pliku już sformatowane
    account=$1
    fi
    
    egrep "^$account" /etc/passwd >/dev/null

    if [ $? -eq 0 ]; then
    #użytkownik taki już istnieje. Nie możemy utworzyć o takiej samej nazwie. Musimy utworzyć trochę 
    #inne konto dodając na końcu liczbę porządkową
    echo "Użytkownik $account istnieje."
    echo "Nie można dodać konta. Generacja nowej nazwy!"
    addnumber=1
    egrep "^$account" /etc/passwd >/dev/null
        while [ $? -eq 0 ]; do
            addnumber=$((addnumber+1))
            tmp_account=$account$addnumber
            egrep "^$tmp_account" /etc/passwd >/dev/null
        done
        account=$tmp_account
    fi

    path_account=/home/$account
    adduser $account --home $path_account --gecos "$name $surname,,,," --disabled-password ##-force-badname
    echo "$account:$account" | sudo chpasswd >/dev/null
    chage -d 0 $account

    egrep "^$account" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo "Użytkownik został poprawnie założony."
    fi

    echo "${account}:${account}" | tee -a list_of_user.txt>/dev/null


}

function create_special_user()
{
    if [ $# -ge 2 ]; then
        #imię i nazwisko
        create_user_now $1 $2

    elif [ $# -eq 1 ]; then
        # Plik
        if [ -e "$1" ]; then
            if file "$1" | grep -q text$; then
                filename="$1"
                while IFS='' read -r line || [[ -n "$line" ]]; do
                    username="$line"
                    create_user_now $username
                done < $filename
            else
                echo "Nie jest to typowy plik tekstowy!"
                exit 1
            fi
        else
            echo "Plik o podanej nazwie ${1} nie istnieje"
            exit 2
        fi
    else
        show_menu
    fi
}