# Wazuh Docker Copyright (C) 2021 Wazuh Inc. (License GPLv2)
FROM amazon/opendistro-for-elasticsearch-kibana:1.13.2
USER kibana
ARG ELASTIC_VERSION=7.10.2
ARG WAZUH_VERSION=5.0.0
ARG WAZUH_APP_VERSION="${WAZUH_VERSION}_${ELASTIC_VERSION}"

WORKDIR /usr/share/kibana
RUN ./bin/kibana-plugin install https://packages.wazuh.com/4.x/ui/kibana/wazuh_kibana-${WAZUH_APP_VERSION}-1.zip

WORKDIR /
USER root
COPY config/entrypoint.sh ./entrypoint.sh
RUN chmod 755 ./entrypoint.sh

ENV PATTERN="" \
    CHECKS_PATTERN="" \
    CHECKS_TEMPLATE="" \
    CHECKS_API="" \
    CHECKS_SETUP="" \
    EXTENSIONS_PCI="" \
    EXTENSIONS_GDPR="" \
    EXTENSIONS_HIPAA="" \
    EXTENSIONS_NIST="" \
    EXTENSIONS_TSC="" \
    EXTENSIONS_AUDIT="" \
    EXTENSIONS_OSCAP="" \
    EXTENSIONS_CISCAT="" \
    EXTENSIONS_AWS="" \
    EXTENSIONS_GCP="" \
    EXTENSIONS_VIRUSTOTAL="" \
    EXTENSIONS_OSQUERY="" \
    EXTENSIONS_DOCKER="" \
    APP_TIMEOUT="" \
    API_SELECTOR="" \
    IP_SELECTOR="" \
    IP_IGNORE="" \
    WAZUH_MONITORING_ENABLED="" \
    WAZUH_MONITORING_FREQUENCY="" \
    WAZUH_MONITORING_SHARDS="" \
    WAZUH_MONITORING_REPLICAS="" \
    ADMIN_PRIVILEGES=""

USER kibana

COPY ./config/custom_welcome /tmp/custom_welcome
COPY --chown=kibana:kibana ./config/welcome_wazuh.sh ./
RUN chmod +x ./welcome_wazuh.sh
ARG CHANGE_WELCOME="true"
RUN ./welcome_wazuh.sh

COPY --chown=kibana:kibana ./config/wazuh.yml /usr/share/kibana/data/wazuh/config/wazuh.yml
COPY --chown=kibana:kibana ./config/wazuh_app_config.sh ./
RUN chmod +x ./wazuh_app_config.sh

COPY --chown=kibana:kibana ./config/kibana_settings.sh ./
RUN chmod +x ./kibana_settings.sh

ENTRYPOINT ./entrypoint.sh
