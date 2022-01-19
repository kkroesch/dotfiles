alias vpnhome="sshuttle --dns -r nas 192.168.1.0/24"
alias vpnnx="sshuttle -r nx 195.186.0.0/16"
alias vpnsz="sshuttle -r nx 10.0.0.0/8"

# Wireguard VPN shortcuts
alias wpn="sudo wg-quick up wg0"
alias wpn-down="sudo wg-quick down wg0"
alias wpn-status="sudo wg-quick status wg0"
alias wpn-ip="sudo wg-quick show wg0 | grep 'Public' | awk '{print \$2}'"
