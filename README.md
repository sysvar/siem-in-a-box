# SIEM IN A BOX
This is a bare bones SIEM built on Elastic ELK using a Docker deployment. Made for a simple one command deployment. Your welcome.

# Features
 - Run on Docker
 - Basic Elastic ELK 7.5.1
 - All Elastic Beats
 - Sample Beats Dashboards

# Pre-Requirements
 - No package pre-requirements
 - For system: 4GB RAM, 6 CPU Treads, 5 GB Disk 

# Testing
 - Only tested on Debian 10

# Installation
```
su -l

wget -O - https://raw.githubusercontent.com/sysvar/siem-in-a-box/master/install.sh | bash
```

# Usage
```
/opt/siem-in-a-box# make

  SIEM IN A BOX

  [+] Commands:

      Cluster Services
      make start                                - ELK Start
      make stop                                 - ELK Stop
      make restart                              - ELK Restart (+ Rebuild)
      make build                                - ELK Config Change (Rebuild Stack)

      Cluster Status
      make status                               - ELK and System Status
      make health                               - Elastic Health
      make indices-[container]                  - Elastic Indices (syslog/logstash/packet/metric/audit/file/heart)

      Cluster Troubleshooting
      make logs-[container]                     - Logs (elastic/logstash/kibana/packet/metric/audit/file/heart)
      make shell-[container]                    - Shell (elastic/logstash/kibana/packet/metric/audit/file/heart)
      make import-[container]                   - Import Default Dashboards (packet/metric/audit/file/heart)

      Cluster Maintenance
      make set-shards                           - Elastic set Number of Shards (Globally)
      make set-replias                          - Elastic set Number of Replicas (Globally)
      make delete                               - Elastic Delete Indices (Dangerous!)

      OS
      make decrypt                              - Decrypt Elastic Datastore (Custom)

```

# Notes
 - The script does an 'apt upgrade'.
 - Files at: /opt/siem-in-a-box

# Logins
 - URL: http://LOCAL-IP:5601
 - User: elastic
 - Pass: changeme

# To Do
 - Network Based Logging
 - TI Integration

