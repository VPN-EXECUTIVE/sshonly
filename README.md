# sshonly Setup By VPN-EXECUTIVE
# Features Service SSH: 
- SSH SSL TLS
- SSH OVPN
- SSH CDN WEBSOCKET
- SSH SLOWDNS
- SSH OHP (OFF)

# Command Install your Server
# Attention please login as root

# Update Server
```
apt update && apt upgrade -y --fix-missing && sleep 2 && reboot
```

# Install Script
```
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://github.com/VPN-EXECUTIVE/sshonly/raw/main/bahan/vpn-executive2.sh && chmod +x vpn-executive2.sh && ./vpn-executive2.sh 
```

# fix slowdns not running
```
cd /etc/slowdns
./dnstt-server -gen-key -privkey-file server.key -pubkey-file server.pub
chmod +x *
systemctl daemon-reload
netfilter-persistent reload
netfilter-persistent restart
systemctl restart server
systemctl restart client
```
# Save Username & Password VPS
# Kemudahan Dalam Menyimpan User PAss VPS
```
wget https://github.com/VPN-EXECUTIVE/sshonly/raw/main/bahan/vpsroot.sh && chmod +x vpsroot.sh && ./vpsroot.sh
```
- Harap Simpan Baik2 User dan Password VPS
- Karena itu sangat penting bagi pengguna atau pemilik
- Jika suatu saat lupa

# VPN-EXECUTIVE
# Support By JAGOANNEON @ronggolawe1986
