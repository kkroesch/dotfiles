ORIG_PROMPT="$PS1"

alias list_ips="ip a | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

function rdap() {
	curl -sL https://rdap.db.ripe.net/ip/$1 | jq ". | .handle, .name, .country" | tr -d '"'
}

function proxon() {
    PROXY_URL=${1:-localhost:1080}
    export HTTPS_PROXY=$PROXY_URL
    export HTTP_PROXY=$PROXY_URL
    export https_proxy=$HTTPS_PROXY
    export http_proxy=$HTTP_PROXY
    export NO_PROXY="127.0.0.0/8,localhost,localaddress,.localdomain.com,*.docker.localhost"
    export PS1=" ⧓ $PS1"
}

function proxoff() {
    unset HTTPS_PROXY
    unset HTTP_PROXY
    unset https_proxy
    unset http_proxy
    unset NO_PROXY
    export PS1="$ORIG_PROMPT"
}
