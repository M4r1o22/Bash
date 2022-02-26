#!/bin/bash
#Zadanie 7 - automatyzacja

# Zadanie 1 - Utworzyć skrrypt ktory będzie tworzył nam użytkownika
    #ręcznie, wybrana opcja z menu
    #jako parametr do skryptu w postaci imiee i nazwisko
    #z pliku tekstowego kilku użytkowników (przyjmiemy plik tekstowy jest już odpowiednio przygotowany czyli
    # użytkownik to pierwasz litera imienia reszta nazwisko. Każda linia w pliku to nowy uzytkownik)

#lib
. ./mylib/infoshow.sh
. ./mylib/my_user.sh

main()
{
if [ $(id -u) -eq 0 ]; then
    #wykonaj czynności gdy root lub sudo
    create_special_user $1 $2
else
    #Pokaż wiadomość
    show_message WARNING "Nie jesteś uprawnionym użytkownikiem. Tylko root może dodać użytkownika!"
fi

}
main $1 $2