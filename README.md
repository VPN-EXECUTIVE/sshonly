# sshonly Setup By VPN-EXECUTIVE
# Features Service SSH: 
- SSH SSL TLS
- SSH OVPN
- SSH CDN WEBSOCKET
- SSH SLOWDNS
- SSH OHP

# Command Install your Server
# Attention please login as root

# Update Server
```
apt update && apt upgrade -y --fix-missing && sleep 2 && reboot
```

# Install Script
```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://github.com/VPN-EXECUTIVE/sshonly/raw/main/vpn-executive.sh && chmod +x vpn-executive.sh && ./vpn-executive.sh 
```

# Finish
# Happy enjoy Gank
