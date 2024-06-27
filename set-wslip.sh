#!/bin/bash

windowsUsername () {
    powershell.exe '$env:USERNAME' | tr -d $'\r'
}

filepath=/mnt/c/Users/$(windowsUsername)/.wslip

if [ ! -f $filepath  ]; then
    touch $filepath
fi

hostname -I > $filepath
