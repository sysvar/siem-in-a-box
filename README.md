# SIEM IN A BOX
This is a bare bones SIEM built on Elastic ELK using a Docker deployment. Made for a simple one command deployment. Your welcome.

# Features
 - Run on Docker
 - Basic ELK
 - All Beats
 - Sample Beats Dashboards

# Pre-Requirements
 - None

# Testing
 - Only tested on Debian 10

# Installation
```
su -l

wget -O - https://raw.githubusercontent.com/sysvar/siem-in-a-box/master/install.sh | bash
```

# Logins
 - URL: http://LOCAL-IP:5601
 - User: elastic
 - Pass: changeme

# To Do
 - Network Based Logging
 - TI Integration

