# Change Log
All notable changes to this project will be documented in this file.

## [v5.0.0]

### Added

- Update to [Wazuh v5.0.0](https://github.com/wazuh/wazuh/tree/5.0-dev)

## Wazuh Docker v4.3.0
### Added

- Update Wazuh to version [4.3.0](https://github.com/wazuh/wazuh/blob/v4.3.0/CHANGELOG.md#v430)

## Wazuh Docker v4.2.0
### Added

- Update Wazuh to version [4.2.0](https://github.com/wazuh/wazuh/blob/v4.2.0/CHANGELOG.md#v420)

## Wazuh Docker v4.1.5
### Added

- Update Wazuh to version [4.1.5](https://github.com/wazuh/wazuh/blob/v4.1.5/CHANGELOG.md#v415)
- Update ODFE compatibility to version 1.13.2

## Wazuh Docker v4.1.4
### Added

- Update Wazuh to version [4.1.4](https://github.com/wazuh/wazuh/blob/v4.1.4/CHANGELOG.md#v414)

## Wazuh Docker v4.1.3
### Added

- Update Wazuh to version [4.1.3](https://github.com/wazuh/wazuh/blob/v4.1.3/CHANGELOG.md#v413)

## Wazuh Docker v4.1.2
### Added

- Update Wazuh to version [4.1.2](https://github.com/wazuh/wazuh/blob/v4.1.2/CHANGELOG.md#v412)

## Wazuh Docker v4.1.1
### Added

- Update Wazuh to version [4.1.1](https://github.com/wazuh/wazuh/blob/v4.1.1/CHANGELOG.md#v411)

## Wazuh Docker v4.1.0
### Added

- Update Wazuh to version [4.1.0](https://github.com/wazuh/wazuh/blob/v4.1.0/CHANGELOG.md#v410)
- Update ODFE compatibility to version 1.12.0
- Add support for Elasticsearch (xpack) images once again (7.10.2)  ([@xr09](https://github.com/xr09)) [#409](https://github.com/wazuh/wazuh-docker/pull/409)
- Re-enable entrypoint scripts  ([@xr09](https://github.com/xr09)) [#435](https://github.com/wazuh/wazuh-docker/pull/435)
- Add Goss binary for healthchecks ([@xr09](https://github.com/xr09)) [$441](https://github.com/wazuh/wazuh-docker/pull/441)
- Update s6-overlay to latest version

## Wazuh Docker v4.0.4_1.11.0

### Added

- Update to Wazuh version [4.0.4](https://github.com/wazuh/wazuh/blob/v4.0.4/CHANGELOG.md#v404)


## Wazuh Docker v4.0.3_1.11.0

### Added

- Update to Wazuh version 4.0.3


## Wazuh Docker v4.0.2_1.11.0

### Added

- Update to Wazuh version 4.0.2

## Wazuh Docker v4.0.1_1.11.0

### Added

- Update to Wazuh version 4.0.1
- Opendistro 1.11.0 compatiblity
- Re-enabled dumping ossec.log to stdout

## Wazuh Docker v4.0.0_1.10.1

### Added

- Update to Wazuh version 4.0.0
- Updating Wazuh cluster key dynamically ([@1stOfHisGame](https://github.com/1stOfHisGame))  [#393](https://github.com/wazuh/wazuh-docker/pull/393)
- Switched to CentOS 7 for base image ([@xr09](https://github.com/xr09)) [#259](https://github.com/wazuh/wazuh-docker/issues/259)
- Using s6-overlay for process management ([@xr09](https://github.com/xr09)) [#274](https://github.com/wazuh/wazuh-docker/issues/274)
- Allow the creation of custom API users ([@xr09](https://github.com/xr09)) [#395](https://github.com/wazuh/wazuh-docker/issues/395)
- OpenDistro support ([@xr09](https://github.com/xr09)) [#373](https://github.com/wazuh/wazuh-docker/pull/373)


### Changed

- Removal of Elastic images


## Wazuh Docker v3.13.2_7.9.1

### Added

- Update to Wazuh version 3.13.2_7.9.1
- Add CLUSTER_NETWORK_HOST environment variable ([@jfut](https://github.com/jfut)) [#372](https://github.com/wazuh/wazuh-docker/pull/372)

### Fixed

- Too many redirects when running on port 80 ([@chowmean](https://github.com/chowmean)) [#377](https://github.com/wazuh/wazuh-docker/pull/377)
- Move Filebeat installation to build stage ([@xr09](https://github.com/xr09)) [#378](https://github.com/wazuh/wazuh-docker/pull/378)


## Wazuh Docker v3.13.1_7.8.0

### Added

- Update to Wazuh version 3.13.1_7.8.0


## Wazuh Docker v3.13.0_7.7.1

### Added

- Update to Wazuh version 3.13.3_7.7.1

### Fixed

- Save agentless state ([@xr09](https://github.com/xr09)) [#350](https://github.com/wazuh/wazuh-docker/pull/350)
- Use HTTP credentials for service check when required ([@xr09](https://github.com/xr09)) [#356](https://github.com/wazuh/wazuh-docker/pull/356)

## Wazuh Docker v3.12.3_7.6.2

### Added

- Update to Wazuh version 3.12.3_7.6.2


## Wazuh Docker v3.12.2_7.6.2

### Added

- Update to Wazuh version 3.12.2_7.6.2

## Wazuh Docker v3.12.1_7.6.2

### Added

- Update to Wazuh version 3.12.1_7.6.2

### Fixed

- Agent timestamp not being properly saved ([@xr09](https://github.com/xr09)) [#323](https://github.com/wazuh/wazuh-docker/pull/323)


## Wazuh Docker v3.12.0_7.6.1

### Added

- Update to Wazuh version 3.12.0_7.6.1


## Wazuh Docker v3.11.4_7.6.1

### Added

- Update to Wazuh version 3.11.4_7.6.1

- Enable HTTP v2 on nginx ([@xr09](https://github.com/xr09)) [#308](https://github.com/wazuh/wazuh-docker/pull/308)

### Fixed

- Updated NGINX config syntax ([@xr09](https://github.com/xr09)) [#303](https://github.com/wazuh/wazuh-docker/pull/303)


## Wazuh Docker v3.11.3_7.5.2

### Added

- Update to Wazuh version 3.11.3_7.5.2

## Wazuh Docker v3.11.2_7.5.1

### Added

- Bumped Node.js to version 10 ([@xr09](https://github.com/xr09)) [#8615cd4](https://github.com/wazuh/wazuh-docker/commit/8615cd4d2152601e55becc7c3675360938e74b6a)

### Fixed

- Fix S3 Plugin ([@AnthonySendra](https://github.com/AnthonySendra)) [#293](https://github.com/wazuh/wazuh-docker/pull/293)

## Wazuh Docker v3.11.1_7.5.1

### Added

- Update to Wazuh version 3.11.1_7.5.1
- Filebeat configuration file updated to latest version ([@manuasir](https://github.com/manuasir)) [#271](https://github.com/wazuh/wazuh-docker/pull/271)
- Allow using the hostname as node_name for managers ([@JPLachance](https://github.com/JPLachance)) [#261](https://github.com/wazuh/wazuh-docker/pull/261)

## Wazuh Docker v3.11.0_7.5.1

### Added

- Update to Wazuh version 3.11.0_7.5.1

## Wazuh Docker v3.10.2_7.5.0

### Added

- Update to Wazuh version 3.10.2_7.5.0

## Wazuh Docker v3.10.2_7.3.2

### Added

- Update to Wazuh version 3.10.2_7.3.2

## Wazuh Docker v3.10.0_7.3.2

### Added

- Update to Wazuh version 3.10.0_7.3.2

## Wazuh Docker v3.9.5_7.2.1

### Added

- Update to Wazuh version 3.9.5_7.2.1

## Wazuh Docker v3.9.4_7.2.0

### Added

- Update to Wazuh version 3.9.4_7.2.0
- Implemented Wazuh Filebeat Module ([jm404](https://www.github.com/jm404)) [#2a77c6a](https://github.com/wazuh/wazuh-docker/commit/2a77c6a6e6bf78f2492adeedbade7a507d9974b2)

## Wazuh Docker v3.9.3_7.2.0

### Fixed
- Wazuh-docker reinserts cluster settings after resuming containers ([@manuasir](https://github.com/manuasir)) [#213](https://github.com/wazuh/wazuh-docker/pull/213)

## Wazuh Docker v3.9.2_7.1.1

### Added

- Update to Wazuh version 3.9.2_7.1.1

## Wazuh Docker v3.9.2_6.8.0

### Added

- Update to Wazuh version 3.9.2_6.8.0

## Wazuh Docker v3.9.1_7.1.0

### Added

- Support for Elastic v7.1.0
- New environment variables for Kibana ([@manuasir](https://github.com/manuasir)) [#22ad43](https://github.com/wazuh/wazuh-docker/commit/22ad4360f548e54bb0c5e929f8c84a186ad2ab88)

## Wazuh Docker v3.9.1_6.8.0

### Added

- Update to Wazuh version 3.9.1_6.8.0 ([#181](https://github.com/wazuh/wazuh-docker/pull/181))

### Fixed

- Fixed `ELASTICSEARCH_KIBANA_IP` environment variable ([@manuasir](https://github.com/manuasir)) ([#181](https://github.com/wazuh/wazuh-docker/pull/181))

## Wazuh Docker v3.9.0_6.7.2

### Changed

- Update Elastic Stack version to 6.7.2.

## Wazuh Docker v3.9.0_6.7.1

### Added

- Support for xPACK authorized requests ([@manuasir](https://github.com/manuasir)) ([#119](https://github.com/wazuh/wazuh-docker/pull/119))
- Add Elasticsearch cluster configuration ([@SitoRBJ](https://github.com/SitoRBJ)). ([#146](https://github.com/wazuh/wazuh-docker/pull/146))
- Add Elasticsearch cluster configuration ([@Phandora](https://github.com/Phandora)) ([#140](https://github.com/wazuh/wazuh-docker/pull/140))
- Setting Nginx to support several user/passwords in Kibana ([@toniMR](https://github.com/toniMR)) ([#136](https://github.com/wazuh/wazuh-docker/pull/136))


### Changed

- Use LS_JAVA_OPTS instead of old LS_HEAP_SIZE ([@ruffy91](https://github.com/ruffy91)) ([#139](https://github.com/wazuh/wazuh-docker/pull/139))
- Changing the original Wazuh docker image to allow adding code in the entrypoint ([@Phandora](https://github.com/phandora)) ([#151](https://github.com/wazuh/wazuh-docker/pull/151))

### Removed

- Removing files from Wazuh image ([@Phandora](https://github.com/phandora)) ([#153](https://github.com/wazuh/wazuh-docker/pull/153))

## Wazuh Docker v3.8.2_6.7.0

### Changed

- Update Elastic Stack version to 6.7.0. ([#144](https://github.com/wazuh/wazuh-docker/pull/144))

## Wazuh Docker v3.8.2_6.6.2

### Changed

- Update Elastic Stack version to 6.6.2. ([#130](https://github.com/wazuh/wazuh-docker/pull/130))

## Wazuh Docker v3.8.2_6.6.1

### Changed

- Update Elastic Stack version to 6.6.1. ([#129](https://github.com/wazuh/wazuh-docker/pull/129))

## Wazuh Docker v3.8.2_6.5.4

### Added

- Add Wazuh-Elasticsearch. ([#106](https://github.com/wazuh/wazuh-docker/pull/106))
- Store Filebeat _/var/lib/filebeat/registry._ ([#109](https://github.com/wazuh/wazuh-docker/pull/109))
- Adding the option to disable some xpack features. ([#111](https://github.com/wazuh/wazuh-docker/pull/111))
- Wazuh-Kibana customizable at plugin level. ([#117](https://github.com/wazuh/wazuh-docker/pull/117))
- Adding env variables for alerts data flow. ([#118](https://github.com/wazuh/wazuh-docker/pull/118))
- New Logstash entrypoint added. ([#135](https://github.com/wazuh/wazuh-docker/pull/135/files))
- Welcome screen management. ([#133](https://github.com/wazuh/wazuh-docker/pull/133))

### Changed

- Update to Wazuh version 3.8.2. ([#105](https://github.com/wazuh/wazuh-docker/pull/105))

### Removed

- Remove alerts created in build time. ([#137](https://github.com/wazuh/wazuh-docker/pull/137))


## Wazuh Docker v3.8.1_6.5.4

### Changed
- Update to Wazuh version 3.8.1. ([#102](https://github.com/wazuh/wazuh-docker/pull/102))

## Wazuh Docker v3.8.0_6.5.4

### Changed

- Upgrade version 3.8.0_6.5.4. ([#97](https://github.com/wazuh/wazuh-docker/pull/97))

### Removed

- Remove cluster.py work around. ([#99](https://github.com/wazuh/wazuh-docker/pull/99))

## Wazuh Docker v3.7.2_6.5.4

### Added

- Improvements to Kibana settings added. ([#91](https://github.com/wazuh/wazuh-docker/pull/91))
- Add Kibana environmental variables for Wazuh APP config.yml. ([#89](https://github.com/wazuh/wazuh-docker/pull/89))

### Changed

- Update Elastic Stack version to 6.5.4. ([#82](https://github.com/wazuh/wazuh-docker/pull/82))
- Add env credentials for nginx. ([#86](https://github.com/wazuh/wazuh-docker/pull/86))
- Improve filebeat configuration ([#88](https://github.com/wazuh/wazuh-docker/pull/88))

### Fixed

- Temporary fix for Wazuh cluster master node in Kubernetes. ([#84](https://github.com/wazuh/wazuh-docker/pull/84))

## Wazuh Docker v3.7.2_6.5.3

### Changed

- Erasing temporary fix for AWS integration. ([#81](https://github.com/wazuh/wazuh-docker/pull/81))

### Fixed

- Upgrading errors due to wrong files. ([#80](https://github.com/wazuh/wazuh-docker/pull/80))


## Wazuh Docker v3.7.0_6.5.0

### Changed

- Adapt to Elastic stack 6.5.0.

## Wazuh Docker v3.7.0_6.4.3

### Added

- Allow custom scripts or commands before service start ([#58](https://github.com/wazuh/wazuh-docker/pull/58))
- Added description for wazuh-nginx ([#59](https://github.com/wazuh/wazuh-docker/pull/59))
- Added license file to match https://github.com/wazuh/wazuh LICENSE ([#60](https://github.com/wazuh/wazuh-docker/pull/60))
- Added SMTP packages ([#67](https://github.com/wazuh/wazuh-docker/pull/67))

### Changed

- Increased proxy buffer for NGINX Kibana ([#51](https://github.com/wazuh/wazuh-docker/pull/51))
- Updated logstash config to remove deprecation warnings ([#55](https://github.com/wazuh/wazuh-docker/pull/55))
- Set ossec user's home path ([#61](https://github.com/wazuh/wazuh-docker/pull/61))

### Fixed

- Fixed a bug that prevents the API from starting when the Wazuh manager was updated. Change in the files that are stored in the volume.  ([#65](https://github.com/wazuh/wazuh-docker/pull/65))
- Fixed script reference ([#62](https://github.com/wazuh/wazuh-docker/pull/62/files))

## Wazuh Docker v3.6.1_6.4.3

Wazuh-Docker starting point.
