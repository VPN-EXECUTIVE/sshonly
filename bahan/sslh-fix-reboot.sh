#!/bin/bash
# ==========================================

sleep 2
systemctl stop sshws 
pkill python
systemctl stop sslh
systemctl daemon-reload
systemctl disable sshws
systemctl disable sslh
systemctl daemon-reload
systemctl enable sslh
systemctl enable sshws
systemctl start sslh 
/etc/init.d/sslh start 
/etc/init.d/sslh restart 
systemctl start sshws
systemctl restart sshws
sleep 5
restart
