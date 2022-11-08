#!/usr/bin/env bash
set -euo pipefail

# check distribution for Ubuntu

check_distro_for_ubuntu() {
    echo "Started checking distribution for Ubuntu at $(date)"

    grep -i ubuntu /etc/*-release &>/dev/null
    if [[ $? == 0 ]]; then 
        echo "Distribution is Ubuntu."
        cat /etc/os-release
        echo ""

        echo "Finished checking distribution for Ubuntu at $(date)"
        echo ""
    else 
        echo "Sorry but this script only runs on Ubunutu."
        cat /etc/*-release
        echo ""

        echo "Finished checking distrbution for Ubuntu at $(date)"
        echo ""

        exit 1
    fi
}

check_distro_for_ubuntu
