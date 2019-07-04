#!/bin/bash
# Wazuh App Copyright (C) 2019 Wazuh Inc. (License GPLv2)


WAZUH_MAJOR=3

##############################################################################
# Wait for the Kibana API to start. It is necessary to do it in this container
# because the others are running Elastic Stack and we can not interrupt them.
#
# The following actions are performed:
#
# Add the wazuh alerts index as default.
# Set the Discover time interval to 24 hours instead of 15 minutes.
# Do not ask user to help providing usage statistics to Elastic.
##############################################################################

##############################################################################
# Customize elasticsearch ip
##############################################################################
if [ "$ELASTICSEARCH_KIBANA_IP" != "" ]; then
  sed -i 's|http://elasticsearch:9200|'$ELASTICSEARCH_KIBANA_IP'|g' /usr/share/kibana/config/kibana.yml
fi

if [ "$KIBANA_IP" != "" ]; then
  kibana_ip="$KIBANA_IP"
else
  kibana_ip="kibana"
fi

KIBANA_PASS=""

if [[ "x${SECURITY_CREDENTIALS_FILE}" == "x" ]]; then
  KIBANA_PASS=${SECURITY_KIBANA_PASS}
else
  input=${SECURITY_CREDENTIALS_FILE}
  while IFS= read -r line
  do
    if [[ $line == *"KIBANA_PASSWORD"* ]]; then
      arrIN=(${line//:/ })
      KIBANA_PASS=${arrIN[1]}
    fi
  done < "$input"
 
fi


if [ ${SECURITY_ENABLED} != "no" ]; then
  auth="-u $SECURITY_KIBANA_USER:${KIBANA_PASS}"
  kibana_secure_ip="https://$kibana_ip"
else
  auth=""
  kibana_secure_ip="http://$kibana_ip"
fi


while [[ "$(curl $auth -k -XGET -I  -s -o /dev/null -w ''%{http_code}'' $kibana_secure_ip:5601/status)" != "200" ]]; do
  echo "Waiting for Kibana API. Sleeping 5 seconds"
  sleep 5
done

# Prepare index selection.
echo "Kibana API is running"

default_index="/tmp/default_index.json"

cat > ${default_index} << EOF
{
  "changes": {
    "defaultIndex": "wazuh-alerts-${WAZUH_MAJOR}.x-*"
  }
}
EOF

sleep 5
# Add the wazuh alerts index as default.
curl $auth -k -POST "$kibana_secure_ip:5601/api/kibana/settings" -H "Content-Type: application/json" -H "kbn-xsrf: true" -d@${default_index}
rm -f ${default_index}

sleep 5
# Configuring Kibana TimePicker.
curl $auth -k -POST "$kibana_secure_ip:5601/api/kibana/settings" -H "Content-Type: application/json" -H "kbn-xsrf: true" -d \
'{"changes":{"timepicker:timeDefaults":"{\n  \"from\": \"now-24h\",\n  \"to\": \"now\",\n  \"mode\": \"quick\"}"}}'

sleep 5
# Do not ask user to help providing usage statistics to Elastic
curl $auth -k -POST "$kibana_secure_ip:5601/api/telemetry/v1/optIn" -H "Content-Type: application/json" -H "kbn-xsrf: true" -d '{"enabled":false}'

# Remove credentials file
if [[ "x${SECURITY_CREDENTIALS_FILE}" == "x" ]]; then
  echo "Security credentials file not used. Nothing to do."
else
  shred -zvu ${SECURITY_CREDENTIALS_FILE}
fi

echo "End settings"
