# Wazuh containers for Docker

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://wazuh.com/community/join-us-on-slack/)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/wazuh)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.wazuh.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://wazuh.com)

In this repository you will find the containers to run:

* wazuh-opendistro: It runs the Wazuh manager, Wazuh API and Filebeat OSS (for integration with ODFE)
* wazuh-kibana-opendistro: Provides a web user interface to browse through alerts data. It includes Wazuh plugin for Kibana, that allows you to visualize agents configuration and status.
* opendistro-for-elasticsearch: An Elasticsearch (ODFE) container (working as a single-node cluster) using ODFE Docker images. **Be aware to increase the `vm.max_map_count` setting, as it's detailed in the [Wazuh documentation](https://documentation.wazuh.com/current/docker/wazuh-container.html#increase-max-map-count-on-your-host-linux).**

In addition, a docker-compose file is provided to launch the containers mentioned above.

* Elasticsearch cluster. In the Elasticsearch Dockerfile we can visualize variables to configure an Elasticsearch Cluster. These variables are used in the file *config_cluster.sh* to set them in the *elasticsearch.yml* configuration file. You can see the meaning of the node variables [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html) and other cluster settings [here](https://github.com/elastic/elasticsearch/blob/master/distribution/src/config/elasticsearch.yml).

## Documentation

* [Wazuh full documentation](http://documentation.wazuh.com)
* [Wazuh documentation for Docker](https://documentation.wazuh.com/current/docker/index.html)
* [Docker hub](https://hub.docker.com/u/wazuh)


### Setup SSL certificate

Before starting the environment it is required to provide an SSL certificate (or just generate one self-signed).

Documentation on how to provide these two can be found at [Wazuh Docer Documentation](https://documentation.wazuh.com/current/docker/wazuh-container.html#production-deployment).


## Environment Variables

Default values are included when available.

### Wazuh
```
API_USERNAME="wazuh"                                # Wazuh API username
API_PASSWORD="wazuh"                                # Wazuh API password - Must comply with requirements
                                                    # (8+ length, uppercase, lowercase, specials chars)

ELASTICSEARCH_URL=https://elasticsearch:9200        # Elasticsearch URL
ELASTIC_USERNAME=admin                              # Elasticsearch Username
ELASTIC_PASSWORD=admin                              # Elasticsearch Password
FILEBEAT_SSL_VERIFICATION_MODE=full                 # Filebeat SSL Verification mode (full or none)
SSL_CERTIFICATE_AUTHORITIES=""                      # Path of Filebeat SSL CA
SSL_CERTIFICATE=""                                  # Path of Filebeat SSL Certificate
SSL_KEY=""                                          # Path of Filebeat SSL Key
```

### Kibana
```
PATTERN="wazuh-alerts-*"        # Default index pattern to use

CHECKS_PATTERN=true             # Defines which checks must to be consider by the healthcheck
CHECKS_TEMPLATE=true            # step once the Wazuh app starts. Values must to be true or false
CHECKS_API=true
CHECKS_SETUP=true

EXTENSIONS_PCI=true             # Enable PCI Extension
EXTENSIONS_GDPR=true            # Enable GDPR Extension
EXTENSIONS_HIPAA=true           # Enable HIPAA Extension
EXTENSIONS_NIST=true            # Enable NIST Extension
EXTENSIONS_TSC=true             # Enable TSC Extension
EXTENSIONS_AUDIT=true           # Enable Audit Extension
EXTENSIONS_OSCAP=false          # Enable OpenSCAP Extension
EXTENSIONS_CISCAT=false         # Enable CISCAT Extension
EXTENSIONS_AWS=false            # Enable AWS Extension
EXTENSIONS_GCP=false            # Enable GCP Extension
EXTENSIONS_VIRUSTOTAL=false     # Enable Virustotal Extension
EXTENSIONS_OSQUERY=false        # Enable OSQuery Extension
EXTENSIONS_DOCKER=false         # Enable Docker Extension

APP_TIMEOUT=20000               # Defines maximum timeout to be used on the Wazuh app requests

API_SELECTOR=true               Defines if the user is allowed to change the selected API directly from the Wazuh app top menu
IP_SELECTOR=true                # Defines if the user is allowed to change the selected index pattern directly from the Wazuh app top menu
IP_IGNORE="[]"                  # List of index patterns to be ignored

WAZUH_MONITORING_ENABLED=true       # Custom settings to enable/disable wazuh-monitoring indices
WAZUH_MONITORING_FREQUENCY=900      # Custom setting to set the frequency for wazuh-monitoring indices cron task
WAZUH_MONITORING_SHARDS=2           # Configure wazuh-monitoring-* indices shards and replicas
WAZUH_MONITORING_REPLICAS=0         #

ADMIN_PRIVILEGES=true               # App privileges
```

## Directory structure

    ├── CHANGELOG.md
    ├── docker-compose.yml
    ├── generate-opendistro-certs.yml
    ├── kibana-odfe
    │   ├── config
    │   │   ├── custom_welcome
    │   │   │   ├── light_theme.style.css
    │   │   │   ├── template.js.hbs
    │   │   │   ├── wazuh_logo_circle.svg
    │   │   │   └── wazuh_wazuh_bg.svg
    │   │   ├── entrypoint.sh
    │   │   ├── kibana_settings.sh
    │   │   ├── wazuh_app_config.sh
    │   │   ├── wazuh.yml
    │   │   └── welcome_wazuh.sh
    │   └── Dockerfile
    ├── LICENSE
    ├── production_cluster
    │   ├── elastic_opendistro
    │   │   ├── elasticsearch-node1.yml
    │   │   ├── elasticsearch-node2.yml
    │   │   ├── elasticsearch-node3.yml
    │   │   └── internal_users.yml
    │   ├── kibana_ssl
    │   │   └── generate-self-signed-cert.sh
    │   ├── nginx
    │   │   ├── nginx.conf
    │   │   └── ssl
    │   │       └── generate-self-signed-cert.sh
    │   ├── ssl_certs
    │   │   └── certs.yml
    │   └── wazuh_cluster
    │       ├── wazuh_manager.conf
    │       └── wazuh_worker.conf
    ├── production-cluster.yml
    ├── README.md
    ├── VERSION
    └── wazuh-odfe
        ├── config
        │   ├── create_user.py
        │   ├── etc
        │   │   ├── cont-init.d
        │   │   │   ├── 0-wazuh-init
        │   │   │   ├── 1-config-filebeat
        │   │   │   └── 2-manager
        │   │   └── services.d
        │   │       └── filebeat
        │   │           ├── finish
        │   │           └── run
        │   ├── filebeat.yml
        │   ├── permanent_data.env
        │   ├── permanent_data.sh
        │   └── wazuh.repo
        └── Dockerfile



## Branches

* `master` branch contains the latest code, be aware of possible bugs on this branch.
* `stable` branch on correspond to the last Wazuh stable version.


## Compatibility Matrix

| Wazuh version | ODFE    | XPACK  |
|---------------|---------|--------|
| v5.0.0        | 1.13.2  | 7.10.2 |
| v4.3.0        | 1.13.2  | 7.10.2 |
| v4.2.0        | 1.13.2  | 7.10.2 |
| v4.1.5        | 1.13.2  | 7.10.2 |
| v4.1.4        | 1.12.0  | 7.10.2 |
| v4.1.3        | 1.12.0  | 7.10.2 |
| v4.1.2        | 1.12.0  | 7.10.2 |
| v4.1.1        | 1.12.0  | 7.10.2 |
| v4.1.0        | 1.12.0  | 7.10.2 |
| v4.0.4        | 1.11.0  |        |
| v4.0.3        | 1.11.0  |        |
| v4.0.2        | 1.11.0  |        |
| v4.0.1        | 1.11.0  |        |
| v4.0.0        | 1.10.1  |        |

## Credits and Thank you

These Docker containers are based on:

*  "deviantony" dockerfiles which can be found at [https://github.com/deviantony/docker-elk](https://github.com/deviantony/docker-elk)
*  "xetus-oss" dockerfiles, which can be found at [https://github.com/xetus-oss/docker-ossec-server](https://github.com/xetus-oss/docker-ossec-server)

We thank you them and everyone else who has contributed to this project.

## License and copyright

Wazuh Docker Copyright (C) 2021 Wazuh Inc. (License GPLv2)

## Web references

[Wazuh website](http://wazuh.com)
