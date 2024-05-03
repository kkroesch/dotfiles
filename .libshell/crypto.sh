# Crypto utils

alias mkpassword="openssl rand -base64 12"
alias mkpassphrase="gpg --gen-random --armor 0 24"

function enc() {
  # Encrypt file
  INFILE=$1
  OUTFILE=$1.enc
  openssl enc -aes-256-cbc -a -salt -in $INFILE -out $OUTFILE
}

function dec() {
  # Decrypt file
  openssl enc -d -aes-256-cbc -a -in $1
}
