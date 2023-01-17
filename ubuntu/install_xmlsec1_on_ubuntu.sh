#!/usr/bin/env bash
set -euo pipefail

# install xmlsec1 on Ubuntu

check_distro_for_ubuntu() {
    echo "Started checking distribution for Ubuntu at $(date)"

    grep -i ubuntu /etc/*-release &>/dev/null
    if [[ $? == 0 ]]; then 
        tput setaf 2; echo "Distribution is Ubuntu."; tput sgr0
        cat /etc/os-release
        echo ""

        echo "Finished checking distribution for Ubuntu at $(date)"
        echo ""
    else 
        tput setaf 1; echo "Sorry but this script only runs on Ubuntu."; tput sgr0
        cat /etc/*-release
        echo ""

        echo "Finished checking distrbution for Ubuntu at $(date)"
        echo ""

        exit 1
    fi
}

check_xmlsec1() { 
    echo "Started checking xmlsec1 at $(date)"

    dpkg -l | grep xmlsec1 &>/dev/null
    if [[ $? == 0 ]]; then 
        tput setaf 2; echo "xmlsec1 is installed."; tput sgr0

        echo "Finished checking xmlsec1 at $(date)"
        echo ""
        
        exit 0
    else 
        tput setaf 1; echo "xmlsec1 is not installed."; tput sgr0

        echo "Finished checking xmlsec1 at $(date)"
        echo ""
    fi
}

install_xmlsec1() {
    printf "\nInstall xmlsec1 on Ubuntu.\n\n"

    check_distro_for_ubuntu
    check_xmlsec1

    start=$(date +%s)
    echo "Started installing xmlsec1 at $(date)"

    sudo apt-get install xmlsec1 -y
    tput setaf 2; echo "Successfully installed xmlsec1."; tput sgr0

    end=$(date +%s)
    echo "Finished installing xmlsec1 at $(date)"

    duration=$(( $end - $start ))
    echo "Total execution time: $duration second(s)"
    echo ""
}

install_xmlsec1
