#!/usr/bin/env bash
set -euo pipefail

# install psql on Ubuntu

# run this script as root or with: sudo ./install_psql_on_ubuntu.sh

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

check_psql() { 
    echo "Started checking psql at $(date)"

    dpkg -l | grep postgresql-client &>/dev/null
    if [[ $? == 0 ]]; then 
        tput setaf 2; echo "psql is installed."; tput sgr0

        echo "Finished checking psql at $(date)"
        echo ""
        
        exit 0
    else 
        tput setaf 1; echo "psql is not installed."; tput sgr0

        echo "Finished checking psql at $(date)"
        echo ""
    fi
}

check_wget() {
    echo "Started checking wget at $(date)"

    dpkg -l | grep wget &>/dev/null
    if [[ $? == 0 ]]; then 
        tput setaf 2; echo "wget is installed."; tput sgr0

        echo "Finished checking wget at $(date)"
        echo ""
    else
        tput setaf 1; echo "wget is not installed."; tput sgr0

        echo "Finished checking wget at $(date)"
        echo ""

        exit 1
    fi
}

install_psql() {
    printf "\nInstall psql on Ubuntu.\n\n"

    check_distro_for_ubuntu
    check_psql
    check_wget

    start=$(date +%s)
    echo "Started installing psql at $(date)"

    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
    apt-get update 
    apt-get install postgresql-client-14 -y
    tput setaf 2; echo "Successfully installed psql."; tput sgr0

    end=$(date +%s)
    echo "Finished installing psql at $(date)"

    duration=$(( $end - $start ))
    echo "Total execution time: $duration second(s)"
    echo ""
}

install_psql
