Host devag
  Hostname 10.5.5.239
  User karsten

Host zwork
  Hostname sppas00016.ads.ktag.ch
  User karsten
  ForwardX11 yes

Host jupyter
  Hostname sppas00016.ads.ktag.ch
  LocalForward 8888 127.0.0.1:8888
  RequestTTY yes
  RemoteCommand jupyter notebook

Host git-ssh.ag.ch
  IdentityFile ~/.ssh/id_ed25519

Host master
  Hostname svpas00020.ads.ktag.ch
  User adskkrr
  IdentityFile ~/.ssh/id_ed25519
  # When using xclip: X11Forwarding yes

Host agmaster
  Hostname svpas10001.ads.ktag.ch
  User root
  IdentityFile ~/.ssh/id_ed25519

Host kubdev
  Hostname svuas00079.ads.ktag.ch
  User adskkrr
  RequestTTY yes
  RemoteCommand zsh
  LocalForward 6443 localhost:6443

Host *ads.ktag.ch
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
    User adskkrr

Host *aads.ktag.ch
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
  User aadskkrr