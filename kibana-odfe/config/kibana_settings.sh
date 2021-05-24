#!/bin/bash
# Wazuh Docker Copyright (C) 2021 Wazuh Inc. (License GPLv2)

WAZUH_MAJOR=4

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
sed -i "s|elasticsearch.hosts:.*|elasticsearch.hosts: $el_url|g" /usr/share/kibana/config/kibana.yml

# If KIBANA_INDEX was set, then change the default index in kibana.yml configuration file. If there was an index, then delete it and recreate.
if [ "$KIBANA_INDEX" != "" ]; then
  if grep -q 'kibana.index' /usr/share/kibana/config/kibana.yml; then
    sed -i '/kibana.index/d' /usr/share/kibana/config/kibana.yml
  fi
    echo "kibana.index: $KIBANA_INDEX" >> /usr/share/kibana/config/kibana.yml
fi

while [[ "$(curl -XGET -I  -s -o /dev/null -w '%{http_code}' -k https://127.0.0.1:5601/app/login)" != "200" ]]; do
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
curl ${auth} -POST -k https://127.0.0.1:5601/api/kibana/settings -H "Content-Type: application/json" -H "kbn-xsrf: true" -d@${default_index}
rm -f ${default_index}

sleep 5
# Configuring Kibana TimePicker.
curl ${auth} -POST -k "https://127.0.0.1:5601/api/kibana/settings" -H "Content-Type: application/json" -H "kbn-xsrf: true" -d \
'{"changes":{"timepicker:timeDefaults":"{\n  \"from\": \"now-12h\",\n  \"to\": \"now\",\n  \"mode\": \"quick\"}"}}'

echo "End settings"
