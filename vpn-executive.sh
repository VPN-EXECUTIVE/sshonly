#!/bin/bash
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
#=========================
echo -e "${ORANGE}

┏┓╋╋┏┳━━━┳━┓╋┏┓┏━━━┳━┓┏━┳━━━┳━━━┳┓╋┏┳━━━━┳━━┳┓╋╋┏┳━━━┓
┃┗┓┏┛┃┏━┓┃┃┗┓┃┃┃┏━━┻┓┗┛┏┫┏━━┫┏━┓┃┃╋┃┃┏┓┏┓┣┫┣┫┗┓┏┛┃┏━━┛
┗┓┃┃┏┫┗━┛┃┏┓┗┛┃┃┗━━┓┗┓┏┛┃┗━━┫┃╋┗┫┃╋┃┣┛┃┃┗┛┃┃┗┓┃┃┏┫┗━━┓
╋┃┗┛┃┃┏━━┫┃┗┓┃┃┃┏━━┛┏┛┗┓┃┏━━┫┃╋┏┫┃╋┃┃╋┃┃╋╋┃┃╋┃┗┛┃┃┏━━┛
╋┗┓┏┛┃┃╋╋┃┃╋┃┃┃┃┗━━┳┛┏┓┗┫┗━━┫┗━┛┃┗━┛┃╋┃┃╋┏┫┣┓┗┓┏┛┃┗━━┓
╋╋┗┛╋┗┛╋╋┗┛╋┗━┛┗━━━┻━┛┗━┻━━━┻━━━┻━━━┛╋┗┛╋┗━━┛╋┗┛╋┗━━━┛
┏━━━┳━━━┳━━━┳━━━┓
┃┏━┓┃┏━┓┃┏━┓┃┏━┓┃
┗┛┏┛┃┃┃┃┣┛┏┛┣┛┏┛┃
┏━┛┏┫┃┃┃┣━┛┏╋┓┗┓┃
┃┃┗━┫┗━┛┃┃┗━┫┗━┛┃
┗━━━┻━━━┻━━━┻━━━┛
${NC}"
read -p "Checking Akses VPS Press ENTER For Installing....."
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
#Chekking Version
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
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
MYIP=$(wget -qO- ipinfo.io/ip);
rm -f setup.sh
clear
if [ -f "/etc/xray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
mkdir /etc/xray
mkdir /var/lib/premium-script;
clear
echo "Masukkan Domain Anda, Jika Anda Tidak Memiliki Domain Klik Enter"
echo "Ketikkan Perintah addhost setelah proses instalasi Script Selesai"
read -p "Hostname / Domain: " host
echo "IP="$host >> /var/lib/premium-script/ipvps.conf
echo "$host" >> /etc/xray/domain
#install v2ray
wget https://raw.githubusercontent.com/VPN-EXECUTIVE/sshonly/main/bahan/ins-cert.sh && chmod +x ins-cert.sh && ./ins-cert.sh
#install ssh ovpn
wget https://raw.githubusercontent.com/VPN-EXECUTIVE/sshonly/main/bahan/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
# Websocket
wget https://raw.githubusercontent.com/VPN-EXECUTIVE/sshonly/main/bahan/ins-ws.sh && chmod +x ins-ws.sh && ./ins-ws.sh
# Ohp Server
wget https://raw.githubusercontent.com/VPN-EXECUTIVE/sshonly/main/bahan/ins-ohp.sh && chmod +x ins-ohp.sh && ./ins-ohp.sh
# BBR
wget https://raw.githubusercontent.com/VPN-EXECUTIVE/sshonly/main/bahan/set-br.sh && chmod +x set-br.sh && ./set-br.sh
#install slowdns
wget https://raw.githubusercontent.com/VPN-EXECUTIVE/sshonly/main/bahan/ins-slowdns && chmod +x ins-slowdns && ./ins-slowdns

rm -rf /root/ins-cert.sh
rm -rf /root/ins-slowdns.sh
rm -rf /root/ssh-vpn.sh
rm -rf /root/set-br.sh
rm -rf /root/ins-ws.sh
rm -rf /root/ins-ohp.sh
history -c
echo "1.2" > /home/ver
cd
echo " "
echo "Installation has been completed!!"echo " "
echo "============================================================================" | tee -a log-install.txt
echo "" | tee -a log-install.txt
echo "----------------------------------------------------------------------------" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 443, 22"  | tee -a log-install.txt
echo "   - OpenVPN                 : TCP 1194, UDP 2200, SSL 990"  | tee -a log-install.txt
echo "   - Stunnel5                : 443, 445, 777"  | tee -a log-install.txt
echo "   - Dropbear                : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - Websocket TLS           : 443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 80"  | tee -a log-install.txt
echo "   - Websocket Ovpn          : 2086"  | tee -a log-install.txt
echo "   - OHP SSH                 : 8181"  | tee -a log-install.txt
echo "   - OHP Dropbear            : 8282"  | tee -a log-install.txt
echo "   - OHP OpenVPN             : 8383"  | tee -a log-install.txt
echo "   - SLOWDNS                    : 53"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo " Reboot 15 Sec"
sleep 15
rm -rf vpn-executive.sh
reboot
