# Wazuh containers for Docker

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://goo.gl/forms/M2AoZC4b2R9A9Zy12)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/wazuh)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.wazuh.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://wazuh.com)

In this repository you will find the containers to run:

* wazuh: It runs the Wazuh manager, Wazuh API and Filebeat (for integration with Elastic Stack)
* wazuh-logstash: It is used to receive alerts generated by the manager and feed Elasticsearch using an alerts template
* wazuh-kibana: Provides a web user interface to browse through alerts data. It includes Wazuh plugin for Kibana, that allows you to visualize agents configuration and status.
* wazuh-nginx: Proxies the Kibana container, adding HTTPS (via self-signed SSL certificate) and [Basic authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#Basic_authentication_scheme).

In addition, a docker-compose file is provided to launch the containers mentioned above. It also launches an Elasticsearch container (working as a single-node cluster) using Elastic Stack Docker images.

## Documentation

* [Wazuh full documentation](http://documentation.wazuh.com)
* [Wazuh documentation for Docker](https://documentation.wazuh.com/current/docker/index.html)
* [Docker hub](https://hub.docker.com/u/wazuh)

## Current release

Containers are currently tested on Wazuh version 3.7.0 and Elastic Stack version 6.4.3. We will do our best to keep this repository updated to latest versions of both Wazuh and Elastic Stack.

## Directory structure

	wazuh-docker
	├── docker-compose.yml
	├── kibana
	│   ├── config
	│   │   ├── entrypoint.sh
	│   │   └── kibana.yml
	│   └── Dockerfile
	├── LICENSE
	├── logstash
	│   ├── config
	│   │   ├── 01-wazuh.conf
	│   │   └── run.sh
	│   └── Dockerfile
	├── nginx
	│   ├── config
	│   │   └── entrypoint.sh
	│   └── Dockerfile
	├── README.md
	├── CHANGELOG.md
	├── VERSION
	├── test.txt
	└── wazuh
	    ├── config
	    │   ├── data_dirs.env
	    │   ├── entrypoint.sh
	    │   ├── filebeat.runit.service
	    │   ├── filebeat.yml
	    │   ├── init.bash
	    │   ├── postfix.runit.service
	    │   ├── wazuh-api.runit.service
	    │   └── wazuh.runit.service
	    └── Dockerfile


## Branches

* `stable` branch on correspond to the last Wazuh-Docker stable version.
* `master` branch contains the latest code, be aware of possible bugs on this branch.
* `3.7.0_6.4.3` (current release) branch. This branch contains the current release referenced in Docker Hub. The container images are installed under the current version of this branch. 

## Credits and Thank you

These Docker containers are based on:

*  "deviantony" dockerfiles which can be found at [https://github.com/deviantony/docker-elk](https://github.com/deviantony/docker-elk)
*  "xetus-oss" dockerfiles, which can be found at [https://github.com/xetus-oss/docker-ossec-server](https://github.com/xetus-oss/docker-ossec-server)

We thank you them and everyone else who has contributed to this project.

## License and copyright

Wazuh App Copyright (C) 2018 Wazuh Inc. (License GPLv2)

## Web references

[Wazuh website](http://wazuh.com)
