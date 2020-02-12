#!/bin/bash

# Pre Install
# If running on Debian 10 Make sure to 'su -' before running this script
# If running on Raspbian Make sure to 'su root' before running this script

echo
echo "     SIEM IN A BOX Install Script"
echo
echo " [+] Installing Updates"
apt update -qq 2>/dev/null
apt install sudo curl net-tools -yqq 2>/dev/null
apt upgrade -yqq 2>/dev/null
echo
echo
echo " [+] Installing Docker"
curl -sSL https://get.docker.com | sh
usermod -aG docker pi
apt install libffi-dev libssl-dev -yqq 2>/dev/null
apt install python python-pip -yqq 2>/dev/null
apt remove python-configparser -yqq 2>/dev/null
echo
echo
echo " [+] Installing Docker Compose"
yes | pip install docker-compose 2>/dev/null
echo
echo
echo " [+] Installing Git"
apt install git -yqq 2>/dev/null
echo
echo
echo " [+] Downloading ELK Stack"
git clone https://github.com/sysvar/siem-in-a-box.git /opt/siem-in-a-box -q 2>/dev/null
echo
echo
echo " [+] Configuring SOC"
#nothing yet
echo
echo
echo " [+] Starting SOC"
cd /opt/siem-in-a-box
make start
sleep 30
echo
echo
echo " [+] Importing Dashboards"
cd /opt/siem-in-a-box
make import-heart
make import-audit
make import-packet
make import-metric
make import-file
echo
echo
echo " [+] Done"
echo
exit 0
