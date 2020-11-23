# Wazuh containers for Docker

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://wazuh.com/community/join-us-on-slack/)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/wazuh)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.wazuh.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://wazuh.com)

In this repository you will find the containers to run:

* wazuh: It runs the Wazuh manager, Wazuh API and Filebeat (for integration with Elastic Stack)
* wazuh-kibana: Provides a web user interface to browse through alerts data. It includes Wazuh plugin for Kibana, that allows you to visualize agents configuration and status.
* wazuh-nginx: Proxies the Kibana container, adding HTTPS (via self-signed SSL certificate) and [Basic authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#Basic_authentication_scheme).
* wazuh-elasticsearch: An Elasticsearch container (working as a single-node cluster) using Elastic Stack Docker images. **Be aware to increase the `vm.max_map_count` setting, as it's detailed in the [Wazuh documentation](https://documentation.wazuh.com/current/docker/wazuh-container.html#increase-max-map-count-on-your-host-linux).** 

In addition, a docker-compose file is provided to launch the containers mentioned above. 

* Elasticsearch cluster. In the Elasticsearch Dockerfile we can visualize variables to configure an Elasticsearch Cluster. These variables are used in the file *config_cluster.sh* to set them in the *elasticsearch.yml* configuration file. You can see the meaning of the node variables [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html) and other cluster settings [here](https://github.com/elastic/elasticsearch/blob/master/distribution/src/config/elasticsearch.yml).

## Documentation

* [Wazuh full documentation](http://documentation.wazuh.com)
* [Wazuh documentation for Docker](https://documentation.wazuh.com/current/docker/index.html)
* [Docker hub](https://hub.docker.com/u/wazuh)

## Directory structure

	wazuh-docker
	├── docker-compose.yml
	├── LICENSE
	├── README.md
	├── CHANGELOG.md
	├── VERSION
	├── test.txt
	└── wazuh
		├── config
		│	├── 00-decrypt_credentials.sh
		│	├── 01-wazuh.sh
		│	├── 02-set_filebeat_destination.sh
		│	├── 03-config_filebeat.sh
		│	├── 20-ossec-configuration.sh
		│	├── 25-backups.sh
		│	├── 35-remove_credentials_file.sh
		│	├── 85-save_wazuh_version.sh
		│	├── create_user.py
		│	├── entrypoint.sh
		│	├── filebeat_to_elasticsearch.yml
		│	├── filebeat_to_logstash.yml
		│	├── filebeat.runit.service
		│	├── permanent_data.env
		│	├── postfix.runit.service
		│	└── wazuh.runit.service
		└── Dockerfile


## Branches

* `stable` branch on correspond to the latest Wazuh-Docker stable version.
* `master` branch contains the latest code, be aware of possible bugs on this branch.
* `Wazuh.Version_ElasticStack.Version` (for example 3.10.2_7.3.2) branch. This branch contains the current release referenced in Docker Hub. The container images are installed under the current version of this branch.

## Credits and Thank you

These Docker containers are based on:

*  "deviantony" dockerfiles which can be found at [https://github.com/deviantony/docker-elk](https://github.com/deviantony/docker-elk)
*  "xetus-oss" dockerfiles, which can be found at [https://github.com/xetus-oss/docker-ossec-server](https://github.com/xetus-oss/docker-ossec-server)

We thank you them and everyone else who has contributed to this project.

## License and copyright

Wazuh Docker Copyright (C) 2019 Wazuh Inc. (License GPLv2)

## Web references

[Wazuh website](http://wazuh.com)
