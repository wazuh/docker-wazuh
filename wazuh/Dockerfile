# Wazuh Docker Copyright (C) 2019 Wazuh Inc. (License GPLv2)
FROM waystonesystems/baseimage-centos:0.2.0

# Arguments
ARG FILEBEAT_VERSION=7.10.2
ARG WAZUH_VERSION=4.1.5-1

# Environment variables
ENV API_USER="foo" \
   API_PASS="bar"

ARG TEMPLATE_VERSION="4.0"
ENV FILEBEAT_DESTINATION="elasticsearch"

RUN rpm --import https://packages.wazuh.com/key/GPG-KEY-WAZUH

RUN echo $'[wazuh] \n\
gpgcheck=1\n\
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH\n\
gpgcheck=0\n\
enabled=1\n\
name=Wazuh repository\n\
baseurl=https://packages.wazuh.com/4.x/yum/\n\
protect=1\n'\
>> /etc/yum.repos.d/wazuh.repo

# Install packages
RUN set -x && \
    curl -sL https://rpm.nodesource.com/setup_8.x | bash - && \
    groupadd -g 1000 ossec && \
    useradd -u 1000 -g 1000 -d /var/ossec ossec && \
    yum update -y && \
    yum upgrade -y &&\
    yum install -y openssl vim expect python-boto python-pip python-cryptography && \
    yum install -y postfix bsd-mailx mailx ca-certificates && \
    yum install -y wazuh-manager-${WAZUH_VERSION} && \
    yum clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -f /var/ossec/logs/alerts/*/*/* && \
    rm -f /var/ossec/logs/archives/*/*/* && \
    rm -f /var/ossec/logs/firewall/*/*/* && \
    rm -f /var/ossec/logs/api/*/*/* && \
    rm -f /var/ossec/logs/cluster/*/*/* && \
    rm -f /var/ossec/logs/ossec/*/*/* && \
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.rpm && \
    rpm -vi filebeat-${FILEBEAT_VERSION}-x86_64.rpm && rm -f filebeat-${FILEBEAT_VERSION}-x86_64.rpm && \
    sed -i "s/^enabled=1/enabled=0/" /etc/yum.repos.d/wazuh.repo

# Services
RUN mkdir /etc/service/wazuh && \
   mkdir /etc/service/postfix && \
   mkdir /etc/service/filebeat

COPY config/wazuh.runit.service /etc/service/wazuh/run
COPY config/postfix.runit.service /etc/service/postfix/run
COPY config/filebeat.runit.service /etc/service/filebeat/run

RUN chmod +x /etc/service/wazuh/run && \
   chmod +x /etc/service/postfix/run && \
   chmod +x /etc/service/filebeat/run 

# Copy configuration files from repository
COPY config/filebeat_to_elasticsearch.yml ./
COPY config/filebeat_to_logstash.yml ./

# Prepare permanent data
# Sync calls are due to https://github.com/docker/docker/issues/9547
COPY config/permanent_data.env /permanent_data.env
COPY config/permanent_data.sh /permanent_data.sh
RUN chmod 755 /permanent_data.sh && \
    sync && \
    /permanent_data.sh && \
    sync && \
    rm /permanent_data.sh 

# Expose ports
EXPOSE 55000/tcp 1514/udp 1515/tcp 514/udp 1516/tcp

# Setting volumes
# Once we declared a volume in the Dockerfile, changes made to that path will have no effect. In other words, any changes made
# to the these paths from here to the end of the Dockerfile will not be taken into account when mounting the volume.
VOLUME ["/var/ossec/api/configuration"]
VOLUME ["/var/ossec/etc"]
VOLUME ["/var/ossec/logs"]
VOLUME ["/var/ossec/queue"]
VOLUME ["/var/ossec/agentless"]
VOLUME ["/var/ossec/var/multigroups"]
VOLUME ["/var/ossec/integrations"]
VOLUME ["/var/ossec/active-response/bin"]
VOLUME ["/var/ossec/wodles"]
VOLUME ["/etc/filebeat"]
VOLUME ["/etc/postfix"]
VOLUME ["/var/lib/filebeat"]

# Prepare entrypoint scripts
# Entrypoint scripts must be added to the entrypoint-scripts directory
RUN mkdir /entrypoint-scripts

COPY config/entrypoint.sh /entrypoint.sh
COPY --chown=root:ossec config/create_user.py /var/ossec/framework/scripts/create_user.py
COPY config/00-decrypt_credentials.sh /entrypoint-scripts/00-decrypt_credentials.sh
COPY config/01-wazuh.sh /entrypoint-scripts/01-wazuh.sh
COPY config/02-set_filebeat_destination.sh /entrypoint-scripts/02-set_filebeat_destination.sh
COPY config/03-config_filebeat.sh /entrypoint-scripts/03-config_filebeat.sh
COPY config/20-ossec-configuration.sh /entrypoint-scripts/20-ossec-configuration.sh
COPY config/25-backups.sh /entrypoint-scripts/25-backups.sh
COPY config/35-remove_credentials_file.sh /entrypoint-scripts/35-remove_credentials_file.sh
COPY config/85-save_wazuh_version.sh /entrypoint-scripts/85-save_wazuh_version.sh
RUN chmod 755 /entrypoint.sh && \
    chmod 755 /entrypoint-scripts/00-decrypt_credentials.sh && \
    chmod 755 /entrypoint-scripts/01-wazuh.sh && \
    chmod 755 /entrypoint-scripts/02-set_filebeat_destination.sh && \
    chmod 755 /entrypoint-scripts/03-config_filebeat.sh && \
    chmod 755 /entrypoint-scripts/20-ossec-configuration.sh && \
    chmod 755 /entrypoint-scripts/25-backups.sh && \
    chmod 755 /entrypoint-scripts/35-remove_credentials_file.sh && \
    chmod 755 /entrypoint-scripts/85-save_wazuh_version.sh

# Load wazuh alerts template.
ADD https://raw.githubusercontent.com/wazuh/wazuh/$TEMPLATE_VERSION/extensions/elasticsearch/7.x/wazuh-template.json /etc/filebeat
RUN chmod go-w /etc/filebeat/wazuh-template.json 

# Run all services
ENTRYPOINT ["/entrypoint.sh"]
