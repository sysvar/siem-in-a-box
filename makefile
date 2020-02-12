# Recipes

# Script Variables (Don't touch)
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
reset=`tput sgr0`
export ips=${shell hostname -I}
banner="${yellow}SIEM IN A BOX${reset}"

# User Variables
kibanaDockerPath='kibana:5601'
elasticPath='http://localhost:9200'
elasticDockerPath='elasticsearch:9200'
elasticUser="elastic"
elasticPass="changeme"
elasticShards="1"
elasticReplicas="0"
indiceOpenDate="*2020.01.*"
indiceCloseDate="*2020.01.*"
indiceDeleteDate="*2019.01.*"



# Runtime
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#


help:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Commands:"
	@echo
	@echo "      ${green}Cluster Services${reset}"
	@echo "      make ${blue}start${reset}  				- ${red}ELK Start${reset}"
	@echo "      make ${blue}stop${reset}	   				- ${red}ELK Stop${reset}"
	@echo "      make ${blue}restart ${reset}  				- ${red}ELK Restart${reset} (+ Rebuild)"
	@echo "      make ${blue}build${reset}  				- ${red}ELK Config Change${reset} (Rebuild Stack)"
	@echo
	@echo "      ${green}Cluster Status${reset}"
	@echo "      make ${blue}status${reset} 				- ${red}ELK and System Status${reset}"
	@echo "      make ${blue}health${reset} 				- ${red}Elastic Health${reset}"
	@echo "      make ${blue}indices-[container]${reset}			- ${red}Elastic Indices${reset} (syslog/logstash/packet/metric/audit/file/heart)"
	@echo
	@echo "      ${green}Cluster Troubleshooting${reset}"
	@echo "      make ${blue}logs-[container]${reset}	   		- ${red}Logs${reset} (elastic/logstash/kibana/packet/metric/audit/file/heart)"
	@echo "      make ${blue}shell-[container]${reset}  			- ${red}Shell${reset} (elastic/logstash/kibana/packet/metric/audit/file/heart)"
	@echo "      make ${blue}import-[container]${reset}	   		- ${red}Import Default Dashboards${reset} (packet/metric/audit/file/heart)"
	@echo
	@echo "      ${green}Cluster Maintenance${reset}"
	@echo "      make ${blue}set-shards${reset} 				- ${red}Elastic set Number of Shards${reset} (Globally)"
	@echo "      make ${blue}set-replias${reset} 				- ${red}Elastic set Number of Replicas${reset} (Globally)"
	@echo "      make ${blue}delete${reset} 				- ${red}Elastic Delete Indices${reset} (Dangerous!)"
	@echo
	@echo "      ${green}OS${reset}"
	@echo "      make ${blue}decrypt${reset}				- ${red}Decrypt Elastic Datastore${reset} (Custom)"
	@echo


restart:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Restarting ELK Services"
	@echo
	@make stop
	@make build
	@make start
	@sleep 5
	@make status
	@echo


start:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Starting ELK Services"
	@echo
	@docker-compose up -d 2>/dev/null
	@sleep 2
	@docker-compose ps
	@echo
	@echo "      IP Address: ${ips}"
	@echo


stop:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${red}[-]${reset} Stopping ELK Services"
	@echo
	@docker-compose down 2>/dev/null
	@sleep 2
	@docker-compose ps
	@echo


build:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Building ELK Services"
	@echo
	@docker-compose build 2>/dev/null
	@echo


status:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "      ELK Service Status"
	@echo
	@echo "  ${green}[+]${reset} Docker Containers"
	@echo
	@docker-compose ps
	@echo
	@sleep 1
	@echo "  ${green}[+]${reset} Networking"
	@echo
	@echo "      IP Address: ${ips}"
	@echo
	@netstat -plunt
	@echo
	@sleep 1
	@echo "  ${green}[+]${reset} Disk"
	@echo
	@df -h
	@echo


logs:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Logstash Logs"
	@echo
	@docker-compose logs logstash
	@echo


logs-logstash:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Logstash Logs"
	@echo
	@docker-compose logs logstash
	@echo


logs-elastic:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Elasticsearch Logs"
	@echo
	@docker-compose logs elasticsearch
	@echo


logs-kibana:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Kibana Logs"
	@echo
	@docker-compose logs kibana
	@echo


logs-packet:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Packetbeat Logs"
	@echo
	@docker-compose logs packetbeat
	@echo


logs-metric:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Metricbeat Logs"
	@echo
	@docker-compose logs metricbeat
	@echo

logs-audit:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Auditbeat Logs"
	@echo
	@docker-compose logs auditbeat
	@echo


logs-file:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Filebeat Logs"
	@echo
	@docker-compose logs filebeat
	@echo


logs-heart:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Heartbeat Logs"
	@echo
	@docker-compose logs heartbeat
	@echo


shell:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Logstash Shell"
	@echo
	@docker exec -it logstash bash
	@echo


shell-logstash:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Logstash Shell"
	@echo
	@docker exec -it logstash bash
	@echo


shell-elastic:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Elasticsearch Shell"
	@echo
	@docker exec -it elasticsearch bash
	@echo


shell-kibana:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Kibana Shell"
	@echo
	@docker exec -it kibana bash
	@echo


shell-packet:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Packetbeat Shell"
	@echo
	@docker exec -it packetbeat bash
	@echo


shell-metric:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Metricbeat Shell"
	@echo
	@docker exec -it metricbeat bash
	@echo


shell-audit:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Auditbeat Shell"
	@echo
	@docker exec -it auditbeat bash
	@echo


shell-file:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Filebeat Shell"
	@echo
	@docker exec -it filebeat bash
	@echo


shell-heart:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Heartbeat Shell"
	@echo
	@docker exec -it heartbeat bash
	@echo


health:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Elastic Health"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/health?v'
	@echo


indices:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} All Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices?v'
	@echo


indices-syslog:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Syslog Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices/syslog-*'
	@echo


indices-logstash:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Logstash Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices/logstash-*'
	@echo


indices-packet:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Packetbeat Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices/packetbeat-*'
	@echo


indices-metric:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Metricbeat Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices/metricbeat-*'
	@echo


indices-audit:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Auditbeat Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices/auditbeat-*'
	@echo


indices-file:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Filebeat Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices/filebeat-*'
	@echo


indices-heart:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Heartbeat Indices"
	@echo
	@curl -XGET -u ${elasticUser}:${elasticPass} '${elasticPath}/_cat/indices/heartbeat-*'
	@echo


open:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Elastic Indices Open"
	@echo
	@curl -XPOST -u ${elasticUser}:${elasticPass} '${elasticPath}/${indiceOpenDate}/_open'
	@echo
	@echo


close:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${red}[-]${reset} Elastic Indices Close"
	@echo
	@curl -XPOST -u ${elasticUser}:${elasticPass} '${elasticPath}/${indiceCloseDate}/_close'
	@echo
	@echo


set-shards:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Elastic Setting Number of Shards"
	@echo
	@curl -XPOST -u ${elasticUser}:${elasticPass} '${elasticPath}/_template/default' -d '{"index_patterns": ["*"],"order": -1,"settings": {"number_of_shards": "${elasticShards}"}}'
	@echo
	@curl -XPOST -u ${elasticUser}:${elasticPass} '${elasticPath}/*' -d '{"index_patterns": ["*"],"order": -1,"settings": {"number_of_shards": "${elasticShards}"}}'
	@echo
	@echo


set-replicas:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Elastic Setting Number of Replicas"
	@echo
	@curl -XPOST -u ${elasticUser}:${elasticPass} '${elasticPath}/_template/default' -d '{"index_patterns": ["*"],"order": -1,"settings": {"number_of_replicas": "${elasticReplicas}"}}'
	@echo
	@curl -XPOST -u ${elasticUser}:${elasticPass} '${elasticPath}/*' -d '{"index_patterns": ["*"],"order": -1,"settings": {"number_of_replicas": "${elasticReplicas}"}}'
	@echo
	@echo


import-packet:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Importing Packetbeat Dashboards"
	@echo
	@docker-compose run packetbeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['${elasticDockerPath}'] -E output.elasticsearch.username=${elasticUser} -E output.elasticsearch.password=${elasticPass} -E setup.kibana.host=${kibanaDockerPath}
	@echo
	@echo


import-metric:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Importing Metricbeat Dashboards"
	@echo
	@docker-compose run metricbeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['${elasticDockerPath}'] -E output.elasticsearch.username=${elasticUser} -E output.elasticsearch.password=${elasticPass} -E setup.kibana.host=${kibanaDockerPath}
	@echo
	@echo


import-audit:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Importing Auditbeat Dashboards"
	@echo
	@docker-compose run auditbeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['${elasticDockerPath}'] -E output.elasticsearch.username=${elasticUser} -E output.elasticsearch.password=${elasticPass} -E setup.kibana.host=${kibanaDockerPath}
	@echo
	@echo


import-file:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Importing filebeat Dashboards"
	@echo
	@docker-compose run filebeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['${elasticDockerPath}'] -E output.elasticsearch.username=${elasticUser} -E output.elasticsearch.password=${elasticPass} -E setup.kibana.host=${kibanaDockerPath}
	@echo
	@echo


import-heart:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Importing Heartbeat Dashboards"
	@echo
	@docker-compose run heartbeat setup -e -E output.logstash.enabled=false -E output.elasticsearch.hosts=['${elasticDockerPath}'] -E output.elasticsearch.username=${elasticUser} -E output.elasticsearch.password=${elasticPass} -E setup.kibana.host=${kibanaDockerPath}
	@echo
	@echo


delete:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${red}[-]${reset} Elastic Indices Deletion"
	@echo
	@echo "      ${red}Data for ${indiceDeleteDate} in Elastic Database is about to be permanently deleted, CTRL+C to cancel${reset}"
	@echo
	@echo "     ${red}7${reset}"
	@sleep 1
	@echo "     ${red}6${reset}"
	@sleep 1
	@echo "     ${red}5${reset}"
	@sleep 1
	@echo "     ${red}4${reset}"
	@sleep 1
	@echo "     ${red}3${reset}"
	@sleep 1
	@echo "     ${red}2${reset}"
	@sleep 1
	@echo "     ${red}1${reset}"
	@sleep 1
	@echo
	@curl -XDELETE -u ${elasticUser}:${elasticPass} '${elasticPath}/${indiceDeleteDate}'
	@echo
	@echo


decrypt:
	@clear
	@echo
	@echo "  ${banner}"
	@echo
	@echo "  ${green}[+]${reset} Decrypt Elastic Datastore"
	@echo
	@echo "      ${red}Data in /data shown below will be overwritten, CTRL+C to cancel${reset}"
	@ls /data
	@echo
	@echo "     ${red}7${reset}"
	@sleep 1
	@echo "     ${red}6${reset}"
	@sleep 1
	@echo "     ${red}5${reset}"
	@sleep 1
	@echo "     ${red}4${reset}"
	@sleep 1
	@echo "     ${red}3${reset}"
	@sleep 1
	@echo "     ${red}2${reset}"
	@sleep 1
	@echo "     ${red}1${reset}"
	@sleep 1
	@echo
	@echo cryptsetup open /dev/mapper/elk-datastore encrypted
	@mount -t ext4 /dev/mapper/encrypted /data/
	@echo
	@ls /data
	@echo