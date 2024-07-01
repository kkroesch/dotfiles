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

#
# Crypto utils
#

alias mkpassword="openssl rand -base64 12"
alias mkpassphrase="gpg --gen-random --armor 0 24"

function encrypt() {
  # Encrypt file
  INFILE=$1
  OUTFILE=$1.enc
  openssl enc -aes-256-cbc -a -salt -in $INFILE -out $OUTFILE
}

function decrypt() {
  # Decrypt file
  openssl enc -d -aes-256-cbc -a -in $1
}

#
# Date Utilities
#

function ts2date {
  date -d @$1 '+%d.%m.%Y %H:%M:%S'
}

