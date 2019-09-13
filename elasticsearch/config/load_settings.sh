#!/bin/bash
# Wazuh Docker Copyright (C) 2019 Wazuh Inc. (License GPLv2)

set -e

if [[ "x${ELASTICSEARCH_PROTOCOL}" = "x" || "x${ELASTICSEARCH_IP}" = "x" || "x${ELASTICSEARCH_PORT}" = "x" ]]; then
  el_url="http://elasticsearch:9200"
else
  el_url="${ELASTICSEARCH_PROTOCOL}://${ELASTICSEARCH_IP}:${ELASTICSEARCH_PORT}"
fi

if [[ "x${WAZUH_API_URL}" = "x" ]]; then
  wazuh_url="https://wazuh"
else
  wazuh_url="${WAZUH_API_URL}"
fi

ELASTIC_PASS=""
KIBANA_USER=""
KIBANA_PASS=""
LOGSTASH_USER=""
LOGSTASH_PASS=""
ADMIN_USER=""
ADMIN_PASS=""
WAZH_API_USER=""
WAZH_API_PASS=""
MONITORING_USER=""
MONITORING_PASS=""

if [[ "x${SECURITY_CREDENTIALS_FILE}" == "x" ]]; then
  ELASTIC_PASS=${SECURITY_ELASTIC_PASSWORD}
  KIBANA_USER=${SECURITY_KIBANA_USER}
  KIBANA_PASS=${SECURITY_KIBANA_PASS}
  LOGSTASH_USER=${SECURITY_LOGSTASH_USER}
  LOGSTASH_PASS=${SECURITY_LOGSTASH_PASS}
  ADMIN_USER=${SECURITY_ADMIN_USER}
  ADMIN_PASS=${SECURITY_ADMIN_PASS}
  WAZH_API_USER=${API_USER}
  WAZH_API_PASS=${API_PASS}
  MONITORING_USER=${SECURITY_MONITORING_USER}
  MONITORING_PASS=${SECURITY_MONITORING_PASS}
else
  input=${SECURITY_CREDENTIALS_FILE}
  while IFS= read -r line
  do
    if [[ $line == *"ELASTIC_PASSWORD"* ]]; then
      arrIN=(${line//:/ })
      ELASTIC_PASS=${arrIN[1]}
    elif [[ $line == *"KIBANA_USER"* ]]; then
      arrIN=(${line//:/ })
      KIBANA_USER=${arrIN[1]}
    elif [[ $line == *"KIBANA_PASSWORD"* ]]; then
      arrIN=(${line//:/ })
      KIBANA_PASS=${arrIN[1]}
    elif [[ $line == *"LOGSTASH_USER"* ]]; then
      arrIN=(${line//:/ })
      LOGSTASH_USER=${arrIN[1]}
    elif [[ $line == *"LOGSTASH_PASSWORD"* ]]; then
      arrIN=(${line//:/ })
      LOGSTASH_PASS=${arrIN[1]}
    elif [[ $line == *"ADMIN_USER"* ]]; then
      arrIN=(${line//:/ })
      ADMIN_USER=${arrIN[1]}
    elif [[ $line == *"ADMIN_PASSWORD"* ]]; then
      arrIN=(${line//:/ })
      ADMIN_PASS=${arrIN[1]}
    elif [[ $line == *"WAZUH_API_USER"* ]]; then
      arrIN=(${line//:/ })
      WAZH_API_USER=${arrIN[1]}
    elif [[ $line == *"WAZUH_API_PASSWORD"* ]]; then
      arrIN=(${line//:/ })
      WAZH_API_PASS=${arrIN[1]}
    elif [[ $line == *"MONITORING_USER"* ]]; then
      arrIN=(${line//:/ })
      MONITORING_USER=${arrIN[1]}
    elif [[ $line == *"MONITORING_PASSWORD"* ]]; then
      arrIN=(${line//:/ })
      MONITORING_PASS=${arrIN[1]}
    fi
  done < "$input"
 
fi


if [ ${SECURITY_ENABLED} != "no" ]; then
  auth="-uelastic:${ELASTIC_PASS} -k"
elif [[ ${ENABLED_XPACK} != "true" || "x${ELASTICSEARCH_USERNAME}" = "x" || "x${ELASTICSEARCH_PASSWORD}" = "x" ]]; then
  auth=""
else
  auth="--user ${ELASTICSEARCH_USERNAME}:${ELASTICSEARCH_PASSWORD}"
fi

until curl ${auth} -XGET $el_url; do
  >&2 echo "Elastic is unavailable - sleeping"
  sleep 5
done

>&2 echo "Elastic is up - executing command"

if [ $ENABLE_CONFIGURE_S3 ]; then
  #Wait for Elasticsearch to be ready to create the repository
  sleep 10
  >&2 echo "Configure S3"
  if [ "x$S3_PATH" != "x" ]; then
    >&2 echo "S3_PATH"
    >&2 echo $S3_PATH
    if [ "x$S3_ELASTIC_MAJOR" != "x" ]; then
      >&2 echo "Elasticsearch major version:"
      >&2 echo $S3_ELASTIC_MAJOR
      bash /usr/share/elasticsearch/config/configure_s3.sh $el_url $S3_BUCKET_NAME $S3_PATH $S3_REPOSITORY_NAME $S3_ELASTIC_MAJOR
    else
      >&2 echo "Elasticserach major version not given"
      bash /usr/share/elasticsearch/config/configure_s3.sh $el_url $S3_BUCKET_NAME $S3_PATH $S3_REPOSITORY_NAME

    fi

  fi

fi

##############################################################################
# Setup passwords for Elastic Stack users
##############################################################################

if [[ $SECURITY_ENABLED == "yes" ]]; then
  MY_HOSTNAME=`hostname`
  echo "Hostname:"
  echo $MY_HOSTNAME
  if [[ $SECURITY_MAIN_NODE == $MY_HOSTNAME ]]; then
    echo "Setting up passwords for all Elastic Stack users"

    echo "Setting remote monitoring password"
    SECURITY_REMOTE_USER_PASS=`date +%s | sha256sum | base64 | head -c 16 ; echo`
    until curl -u elastic:${ELASTIC_PASS} -k -XPUT -H 'Content-Type: application/json' 'https://localhost:9200/_xpack/security/user/remote_monitoring_user/_password ' -d '{ "password":"'$SECURITY_REMOTE_USER_PASS'" }'; do
      >&2 echo "Unavailable password seeting- sleeping"
      sleep 2
    done
    echo "Setting Kibana password"
    curl -u elastic:${ELASTIC_PASS} -k -XPOST -H 'Content-Type: application/json' 'https://localhost:9200/_xpack/security/role/service_wazuh_app ' -d ' { "indices": [ { "names": [ ".kibana*", ".reporting*", ".monitoring*" ],  "privileges": ["read"] }, { "names": [ "wazuh-monitoring*", ".wazuh*" ],  "privileges": ["all"] } , { "names": [ "wazuh-alerts*" ],  "privileges": ["read", "view_index_metadata"] }  ] }'
    sleep 5
    curl -u elastic:${ELASTIC_PASS} -k -XPOST -H 'Content-Type: application/json' "https://localhost:9200/_xpack/security/user/$KIBANA_USER"  -d '{ "password":"'$KIBANA_PASS'", "roles" : [ "kibana_system", "service_wazuh_app"],  "full_name" : "Service Internal Kibana User" }'
    echo "Setting APM password"
    SECURITY_APM_SYSTEM_PASS=`date +%s | sha256sum | base64 | head -c 16 ; echo`
    curl -u elastic:${ELASTIC_PASS} -k -XPUT -H 'Content-Type: application/json' 'https://localhost:9200/_xpack/security/user/apm_system/_password ' -d '{ "password":"'$SECURITY_APM_SYSTEM_PASS'" }'
    echo "Setting Beats password"
    SECURITY_BEATS_SYSTEM_PASS=`date +%s | sha256sum | base64 | head -c 16 ; echo`
    curl -u elastic:${ELASTIC_PASS} -k -XPUT -H 'Content-Type: application/json' 'https://localhost:9200/_xpack/security/user/beats_system/_password ' -d '{ "password":"'$SECURITY_BEATS_SYSTEM_PASS'" }'
    echo "Setting Logstash password"
    curl -u elastic:${ELASTIC_PASS} -k -XPOST -H 'Content-Type: application/json' 'https://localhost:9200/_xpack/security/role/service_logstash_writer ' -d '{ "cluster": ["manage_index_templates", "monitor", "manage_ilm"], "indices": [ { "names": [ "*" ],  "privileges": ["write","delete","create_index","manage","manage_ilm"] } ] }'
    sleep 5
    curl -u elastic:${ELASTIC_PASS} -k -XPOST -H 'Content-Type: application/json' "https://localhost:9200/_xpack/security/user/$LOGSTASH_USER" -d '{ "password":"'$LOGSTASH_PASS'", "roles" : [ "service_logstash_writer", "logstash_system"],  "full_name" : "Service Internal Logstash User" }'
    echo "Passwords established for all Elastic Stack users"
    echo "Creating Admin user"
    curl -u elastic:${ELASTIC_PASS} -k -XPOST -H 'Content-Type: application/json' "https://localhost:9200/_xpack/security/user/$ADMIN_USER" -d '{ "password":"'$ADMIN_PASS'", "roles" : [ "superuser"],  "full_name" : "Wazuh admin" }'
    echo "Admin user created"
    echo "Setting monitoring user"
    curl -u elastic:${ELASTIC_PASS} -k -XPOST -H 'Content-Type: application/json' 'https://localhost:9200/_xpack/security/role/service_monitoring_reader ' -d '{ "cluster": ["manage", "monitor"], "indices": [ { "names": [ "*" ],  "privileges": ["write","create_index","manage","read", "index"] } ] }'
    sleep 5
    curl -u elastic:${ELASTIC_PASS} -k -XPOST -H 'Content-Type: application/json' "https://localhost:9200/_xpack/security/user/$MONITORING_USER" -d '{ "password":"'$MONITORING_PASS'", "roles" : [ "service_monitoring_reader", "snapshot_user"],  "full_name" : "Service Internal Monitoring User" }'
  fi
fi

# Modify wazuh-alerts template shards and replicas
sed -i 's:"index.number_of_shards"\: "3":"index.number_of_shards"\: "'$WAZUH_ALERTS_SHARDS'":g' /usr/share/elasticsearch/config/wazuh-template.json
sed -i 's:"index.number_of_replicas"\: "0":"index.number_of_replicas"\: "'$WAZUH_ALERTS_REPLICAS'":g' /usr/share/elasticsearch/config/wazuh-template.json

# Insert default templates
cat /usr/share/elasticsearch/config/wazuh-template.json | curl -XPUT "$el_url/_template/wazuh" ${auth} -H 'Content-Type: application/json' -d @-
sleep 5

# Prepare Wazuh API credentials
API_PASS_Q=`echo "$WAZH_API_PASS" | tr -d '"'`
API_USER_Q=`echo "$WAZH_API_USER" | tr -d '"'`
API_PASSWORD=`echo -n $API_PASS_Q | base64`

echo "Setting API credentials into Wazuh APP"
CONFIG_CODE=$(curl -s -o /dev/null -w "%{http_code}" -XGET $el_url/.wazuh/_doc/1513629884013 ${auth})

if [ "x$CONFIG_CODE" != "x200" ]; then
  curl -s -XPOST $el_url/.wazuh/_doc/1513629884013 ${auth} -H 'Content-Type: application/json' -d'
  {
    "api_user": "'"$API_USER_Q"'",
    "api_password": "'"$API_PASSWORD"'",
    "url": "'"$wazuh_url"'",
    "api_port": "55000",
    "insecure": "true",
    "component": "API",
    "cluster_info": {
      "manager": "wazuh-manager",
      "cluster": "Disabled",
      "status": "disabled"
    },
    "extensions": {
      "oscap": true,
      "audit": true,
      "pci": true,
      "aws": true,
      "virustotal": true,
      "gdpr": true,
      "ciscat": true
    }
  }
  ' > /dev/null
else
  echo "Wazuh APP already configured"
fi
sleep 5

curl -XPUT "$el_url/_cluster/settings" ${auth} -H 'Content-Type: application/json' -d'
{
  "persistent": {
    "xpack.monitoring.collection.enabled": true
  }
}
'

# Set cluster delayed timeout when node falls
curl -X PUT "$el_url/_all/_settings" ${auth} -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index.unassigned.node_left.delayed_timeout": "'"$CLUSTER_DELAYED_TIMEOUT"'"
  }
}
'

# Remove credentials file.

if [[ "x${SECURITY_CREDENTIALS_FILE}" == "x" ]]; then
  echo "Security credentials file not used. Nothing to do."
else
  shred -zvu ${SECURITY_CREDENTIALS_FILE}
fi

echo "Elasticsearch is ready."
