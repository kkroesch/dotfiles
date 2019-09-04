ORIG_PROMPT="$PS1"

function proxon() {
    export HTTPS_PROXY=clientproxy.corproot.net:8079
    export HTTP_PROXY=clientproxy.corproot.net:8079
    export https_proxy=$HTTPS_PROXY
    export http_proxy=$HTTP_PROXY
    export NO_PROXY="127.0.0.0/8,localhost,*.corproot.net,*.scapp-console.swisscom.com"
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
