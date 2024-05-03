FROM ubuntu:latest

# Setzen Sie die Umgebungsvariablen für den Proxy (falls erforderlich)
#ENV HTTP_PROXY=http://httpproxy.ag.ch:8080
#ENV HTTPS_PROXY=http://httpproxy.ag.ch:8080

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3 python3-pip python3-venv python3-nose python3-dev python3-numpy python3-plotly python3-ipython ipython3 \
    vim exa git build-essential zsh curl \
    net-tools dnsutils nmap mtr iftop 

RUN chsh -s $(which zsh)
RUN ln -fs /usr/share/zoneinfo/Europe/Zurich /etc/localtime
RUN useradd -ms /bin/zsh developer
# RUN echo "developer:password" | chpasswd
WORKDIR /home/developer

# Install Oh-my-ZSH
USER developer
RUN sh -c "$(curl -k -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Dotfiles
RUN mkdir Projects && \
    git init --bare Projects/dotfiles.git && \
    export DOTFILES=$HOME/Projects/dotfiles.git && \
    cd $DOTFILES && \
    git remote add origin https://github.com/kkroesch/dotfiles.git && \
    cd && \
    [ -f .zshrc ] && rm .zshrc && \
    git --git-dir=$DOTFILES --work-tree=$HOME pull origin master && \
    git config --global init.defaultBranch master && \
    echo 'export DOTFILES=$HOME/Projects/dotfiles.git' >> .zshrc && \
    echo 'alias dotfile="git --git-dir=$DOTFILES --work-tree=$HOME"' >> .alias && \
    echo 'alias la="exa -la"' >> .alias && \
    git --git-dir=$DOTFILES --work-tree=$HOME config --local status.showUntrackedFiles no  # to ignore all the other stuff in $HOME && \

ENTRYPOINT ["zsh"]

