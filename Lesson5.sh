#!/bin/bash

# Poznajmy pętle.

function example_01_for()
{
    words="A B C D E F G H I J K L M"
    echo $words
    echo "Nasz alfabet"
    for word in $words
    do  
        echo -n "${word} "
    done
    echo ""
}

function example_02_for()
{
    words="A B C D E F G H I J K L M"
    echo $words
    echo "Nasz alfabet:"
    for word in "$words"
    do  
        echo -n "${word}."
    done
    echo ""
}
function example_03_for()
{
    echo "Iteracja na elementarz podanych w pętli:"
    for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
    do  
        echo "Witam cię $i raz."
    done
    echo ""
}

function example_04_for()
{
    echo "Dni tygodnia"
    j=1
    for day in Poniedziałek Wtorek Środa Czwartek Piątek sobota Niedziela
    do  
        echo "${day} jest $((j++)) dniem."
    done
}

function example_05_for()
{
    echo "Dni tygodnia"
    j=1
    for day in "Poniedziałek" "Wtorek" "Środa" "Czwartek" "Piątek" "sobota" "Niedziela"
    do  
        echo "${day} jest $((j++)) dniem."
    done
}
function example_06_for()
{
    echo "Dni tygodnia"
    j=1
    for day in "Poniedziałek Wtorek środa Czwartek Piątek sobota Niedziela"
    do  
        echo "${day} jest $((j++)) dniem."
    done
    echo ""
}

function example_07_for()
{
    echo "Zakres"
    j=1
    for i in {1..20}
    do  
        echo "Witam cie $i raz."
    done
    echo ""
}

function example_08_for()
{
    echo "Zakres z przeskokiem tylko dla ${BASH_VERSION}"
    j=1
    for i in $(seq 1 2 20)
    do  
        echo "Witam cie $i raz."
    done
    echo ""
}

function example_09_for()
{
    echo "Na styl C:"
    j=1
    for (( i=1; i <=20; i++))
    do  
        echo "Witam cie $i raz."
    done
    echo ""
}

function example_01_while()
{
    count=1
    while [ $count -le 20 ]
    do  
        echo "Nasz licznik while: $count."
    ((count++))
    done
}
function example_01_until()
{
    count=1
    until [ $count -gt 20 ]
    do  
        echo "Nasz licznik until: $count."
    ((count++))
    done
}

function example_01_for_continue()
{
    echo "Iteracja na elementarz podanych w pętli:"
    for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
    do  
        if [ $i == '10' ]; then
            echo "test"
            break
        fi

        echo "Witam cię $i raz."
    done
    echo ""
}
function example_01_while()
{
    count=1
    while [ $count -le 20 ]
    do  
        echo "Nasz licznik while: $count."
    ((count++))
    done
}
function example_02_until()
{
    count=1
    until [ $count -gt 20 ]
    do  
        if [ $count -eq 10 ]; then
        ((count++))
        break
    fi
        echo "Nasz licznik until: $count."
    ((count++))
    done
}
function example_01_select()
{
    options="Wersja Użytkownicy Grupy Wyjście"
    PS3="Wybierz opcję: "
    select option in $options
    do  
        if [ $option == 'Wyjście' ]
        then
            echo "Pa PA"
            break
        fi
        echo "Wybrałeś opcję: $option"
    done
}
function main()
{
    #example_09_for
    #example_01_while
    #example_02_until
    #example_01_for_continue
    example_01_select
}
main