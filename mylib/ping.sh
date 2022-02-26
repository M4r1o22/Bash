#!/bin/bash

#skrypt pingujący do pliku z zapisem godziny
ping 192.168.2.2 -s 1424 
while read line; 
    do echo -e `date +%H:%M` - $line; 
    done 
    #> log_ping3.log
    tee log_ping.log

#ping 192.168.2.2 -s 1424 | while read line; do echo -e `date +%H:%M` - $line; done > log_ping3.log
