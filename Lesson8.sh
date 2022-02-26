#!/bin/bash

#title          : Lesson8.sh
#description    :
#author         : Piotr Kośka
#date           : 24.02.2018
#version        : v1.0
#usage          :
#notes          :
#bash_version   : 4.4.12
#editor         : visual studio code

#update by koji :2021.12.29
#===========================================

# [PL]
# Lekcja 8 - na moim kanale pojawił się film o namespace (link: https://www.youtube.com/watch?v=cOOCJjNKwRQ)
#       W filmie tym tworzyłem namespace recznie.
#       
#       W tej lekci spróbujemy tworzenie namespace sobie zautomatyzować.
#       Zadanie:
#           1. Tworzymy skrypt tworzący w systemie linux namespace.
#           2. Skrypt nas nie ogranicza - możemy stworzyć ile chcemy namespace (oczywiście bez przesady :) nie odpowiadam za uszkodenia systemu;))
#           3. Możemy indywidualnie zarządzać utworzonymi namespace.
#           4. Możemy podpiąć dowolny interfejs sieciowy.
#           5. Mamy możliwość nadania adresu ip każdemu z tych namespace.
#           6. Mozemy wykonać każdą komende w konteksiec namespoace.
#           7. Możemy zwolnić nasz interfejs
#           8. Wykorzystamy oprogramowanie openvswitch do komunikacji miedzy namespace a nasza siecia maszyną virtualną z systemem Linux.
#           9. Zadanie bonusowe - stworzyc funkcje instalująca nasz pakiet openvswitch-switch

#BEGIN

. ./mylib/mnamespace.sh

#END