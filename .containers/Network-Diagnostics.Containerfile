FROM archlinux:base

# Aktualisieren Sie das System und installieren Sie die erforderlichen Pakete
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm zsh

RUN pacman -S --noconfirm git && \
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Setzen Sie die ZSH als Standard-Shell
SHELL ["/bin/zsh", "-c"]

# Aktualisieren Sie das System und installieren Sie die erforderlichen Pakete
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm wireshark-cli nmap netcat tcpdump hping3 arp-scan nmap-ncat ngrep inetutils net-tools ettercap openvas lynis

# Löschen Sie den Paket-Cache, um die Größe des Images zu reduzieren
RUN pacman -Scc --noconfirm

# Führen Sie den Container als nicht privilegierter Benutzer aus (optional)
USER nobody

ENTRYPOINT ["zsh"]
