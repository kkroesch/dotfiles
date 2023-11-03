#
# Utility functions
#

function ok() {
    echo -e "\e[1;32m$@\e[0m"
}

function error() {
    echo -e "\e[1;31mERROR: \e[0m\e[31m$@\e[0m"
}

function warning() {
    echo -e "\e[33mWARNING: $@\e[0m"
}

function fatal() {
    error $1
    exit 1
}

