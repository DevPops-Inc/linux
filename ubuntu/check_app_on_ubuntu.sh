#!/usr/bin/env bash
set -euo pipefail

# check application on Ubuntu

# you can run this script with: ./check_app_on_ubuntu.sh < application > 

app=$1 # throws unbound variable error if argument isn't passed when running from command line

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

get_app() {
    if [ -z $app ]; then 
        read -p "Please type the terminal application you wish to chedck and press the \"return\" key (Example: wget): " app

        echo ""
    else 
        echo $app &>/dev/null
    fi
}

check_parameters() {
    echo "Started checking parameter(s) at $(date)"
    valid="true"

    echo "Parameter(s):"
    echo "-------------"
    echo "app: $app"
    echo "-------------"

    if [ -z $app ]; then 
        tput setaf 1; echo "app is not set."; tput sgr0
        valid="false"
    fi

    if [ $valid == "true" ]; then 
        tput setaf 2; echo "All parameter check(s) passed."; tput sgr0
        
        echo "Finished checking parameter(s) at $(date)"
        echo ""
    else 
        tput setaf 1; echo "One or more parameters are incorrect."; tput sgr0

        echo "Finished checking parameter(s) at $(date)"
        echo ""

        exit 1
    fi
}

check_app() { 
    printf "\nCheck app on Ubuntu.\n\n"
    check_distro_for_ubuntu

    get_app
    check_parameters

    start=$(date +%s)
    echo "Started checking $app at $(date)"

    dpkg -l | grep $app &>/dev/null
    if [[ $? == 0 ]]; then 
        tput setaf 2; echo "$app is installed."
        echo "Successfully checked $app"; tput sgr0

        end=$(date +%s)
        echo "Finished checking $app at $(date)"

        duration=$(( $end - $start ))
        echo "Total execution time: $duration second(s)"
        echo ""
    else # doesn't go into else block if you check an app that isn't installed
        tput setaf 1; echo "$app is not installed."; tput sgr0
        tput setaf 2; echo "Successfully checked $app"; tput sgr0

        end=$(date +%s)
        echo "Finished checking $app at $(date)"

        duration=$(( $end - $start ))
        echo "Total execution time: $duration second(s)"
        echo ""

        exit 1
    fi
}

check_app
