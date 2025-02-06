# Wireguard VPN shortcuts
alias wpn="sudo wg-quick up wg0"
alias wpn-down="sudo wg-quick down wg0"
alias wpn-status="sudo wg-quick status wg0"
alias wpn-ip="sudo wg-quick show wg0 | grep 'Public' | awk '{print \$2}'"

# Internetbox VPN
vpnhome () {
  nmcli con up vpn.kroesch.net
  sudo resolvectl dns ppp0 192.168.11.151
  sudo resolvectl domain ppp0 "~."
}
