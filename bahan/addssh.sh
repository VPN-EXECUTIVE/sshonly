#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Sedang Mengecek Akses VPS"
IZIN=$( curl http://akses.jagoanneon-premium.com:81/akses | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "\e[0;32mAkses Di Izinkan...\e[0m"
else
echo -e "\033[41;37mVPS tidak diijinkan\e[0m";
echo "Kontak Admin Untuk Mendapatkan Akses Script"
echo "Facebook   : Generasi Ronggolawe Tuban"
echo "WhatsApp   : 087743253904"
exit 0
fi
clear
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
echo -e "\033[1;93m╒═══════════════════════════════════╕\033[0m"
echo -e "\e[42m      Create Account  SSH Ovpn  WS NS       \E[0m"
echo -e "\033[1;93m╘═══════════════════════════════════╛\033[0m"
domain=$(cat /etc/xray/domain)
PUB=$( cat /etc/slowdns/server.pub )
NS=`cat /etc/dns/domain`
clear
read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (Days): " masaaktif

IP=$(wget -qO- ipinfo.io/ip);
ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2|sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2|sed 's/ //g')"

ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear
systemctl restart sshws
systemctl restart vpnws
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
systemctl restart client
systemctl restart server
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
cat > /home/vps/public_html/ssh-$Login.txt <<-END
_______________________________________________________
       Detail  Account SSH OVPN  $LOGIN
              SETUP BY VPN-EXECUTIVE
_______________________________________________________

Username         : $Login
Password         : $Pass
Expired          : $expi
__________________________________
IP               : $IP
Host             : $domain
Host Slowdns     : ${NS}
Pub Key          : ${PUB}
Port OpenSSH     : 22
Port Dropbear    : 109 ,143
Port Dropbear WS : 109
Port SSH WS    : 80
Port SSH SSL WS  : 443
Port SSL/TLS     : 443
Port OVPN WS  : 2086
Port OVPN SSL    : 990
Port OVPN TCP    : 1194
Port OVPN UDP    : 2200
Proxy Squid    : 3128
BadVPN UDP       : 7100 s/d 7500
__________________________________
Payload NONTLS : GET / HTTP/1.1[crlf]host: $domain[crlf]Connection: keep-alive[crlf]Upgrade: websocket[crlf][crlf]
__________________________________
Payload WSS: GET wss://[host] [protocol][crlf]Host: HOSTNAME_BUG[crlf]Connection: Upgrade[crlf]Upgrade: websocket[crlf][crlf]

SNI
$domain

REMOTE PROXY
IP_BUG:443

SSH
$domain:443@$Login:$Pass
__________________________________
OpenVPN WS SSL : http://$domain:81/tcpws.ovpn
OpenVPN SSL : http://$domain:81/ssl.ovpn
OpenVPN TCP : http://$domain:81/tcp.ovpn
OpenVPN UDP : http://$domain:81/udp.ovpn
__________________________________

END
clear
cat > /home/vps/public_html/configmuu1-$Login.txt <<-END
_______________________________________________________
    CONFIG SSH WEBSOCKET TLS  HTTPCUSTOM
                          CEK  DENGAN TEPAT
_______________________________________________________
>>>>>Payload<<<<<<

GET wss://[host] [protocol][crlf]Host: HOSTNAME_BUG[crlf]Connection: Upgrade[crlf]Upgrade: websocket[crlf][crlf]

>>>>Remote Proxy<<<<

IP_BUG:443

>>>>SNI<<<<<

$domain

>>>>>>Host-PortSSH<<<<<<

$domain:443@$Login:$Pass

__________________________________

END
clear

cat > /home/vps/public_html/configmu-$Login.txt <<-END
_______________________________________________________
 CONFIG SSH WEBSOCKET NON TLS  HTTPCUSTOM
                              CEK DENGAN TEPAT
_______________________________________________________
>>>>>Payload<<<<<<

GET / HTTP/1.1[crlf]host: $domain[crlf]Connection: keep-alive[crlf]Upgrade: websocket[crlf][crlf]

>>>>>>Host-PortSSH<<<<<<

$domain:80@$Login:$Pass

__________________________________

END
clear
echo -e ""
echo -e "================================"
echo -e "Informasi Detail Account SSH & OpenVPN "
echo -e "================================"
echo -e "IP/Host       : $IP"
echo -e "Domain        : ${domain}"
echo -e "================================"
echo -e "Slowdns Domain        : ${NS}"
echo -e "Slowdns Key        : ${PUB}"
echo -e "================================"
echo -e "Username      : $Login"
echo -e "Password      : $Pass"
echo -e "================================"
echo -e "Dropbear      : 109, 143"
echo -e "SSL/TLS       : $ssl"
echo -e "Port Squid    : $sqd"
echo -e "OHP SSH       : 8181"
echo -e "OHP Dropbear  : 8282"
echo -e "OHP OpenVPN   : 8383"
echo -e "================================"
echo -e "Ssh Ws SSL    : $ws"
echo -e "Ssh Ws No SSL : $ws2"
echo -e "Ovpn Ws       : 2086"
echo -e "================================"
echo -e "Port TCP      : $ovpn"
echo -e "Port UDP      : $ovpn2"
echo -e "Port SSL      : 990"
echo -e "================================"
echo -e "OVPN TCP      : http://$IP:81/tcp.ovpn"
echo -e "OVPN UDP      : http://$IP:81/udp.ovpn"
echo -e "OVPN SSL      : http://$IP:81/ssl.ovpn"
echo -e "BadVpn        : 7100-7200-7300"
echo -e "================================"
echo -e "Created       : $hariini"
echo -e "Expired       : $expi"
echo -e "================================"
echo -e "Payload Websocket TLS"
echo -e "━━━━━━━━━━━━"
echo -e "GET wss://[host] [protocol][crlf]Host: HOSTNAME_BUG[crlf]Connection: Upgrade[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "================================"
echo -e "Payload Websocket No TLS"
echo -e "━━━━━━━━━━━━"
echo -e "GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "================================"
echo -e "Config SLOWDNS By HTTP CUSTOM"
echo -e "━━━━━━━━━━━"
echo -e "1.1.1.1:${PUB}@${Login}:${Pass}@${NS}"
echo -e "================================"
echo -e "Link Akunmu: http://$domain:81/ssh-$Login.txt"
echo -e "================================"
echo -e "Link CONFIG HC SSH WS-TLS : http://$domain:81/configmuu1-$Login.txt"
echo -e "================================"
echo -e "Link CONFIG HC SSH WS-NONE: http://$domain:81/configmu-$Login.txt"
echo -e "================================"
read -n 1 -s -r -p "Press any key to back on menu"
menu
