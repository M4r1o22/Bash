#!/bin/bash

#Zadanie 1. Przygotuj funkcje w pliku intall.sh i uzyj jej w pliku Lesson4.sh

# Solution

. ./mylib/install.sh

show_message INFO "Witajcie! Jestem z innego pliku."
install_pack unzip zip