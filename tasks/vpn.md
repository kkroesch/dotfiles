# VPN tasks

## Commands

Import OpenVPN configurations

   openvpn3 config-import --config vpn.crb.ch.ovpn
   openvpn3 configs-list

Establish VPN session and troubleshoot

   openvpn3 session-start --config vpn.crb.ch.ovpn
   openvpn3 session-stats --config vpn.crb.ch.ovpn
   openvpn3 log --config vpn.crb.ch.ovpn

Disconnect VPN

   openvpn3 session-manage --config vpn.crb.ch.ovpn --disconnect
