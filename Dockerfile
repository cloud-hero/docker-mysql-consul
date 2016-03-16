FROM debian:latest
MAINTAINER andrei@cloudhero.io

RUN apt-get update -qq && apt-get -y install mysql-client wget unzip
RUN rm -rf /var/lib/apt/lists/*

#Consul template version and download URL
ENV CT_VERS 0.14.0
ENV CT_URL https://releases.hashicorp.com/consul-template/$CT_VERS/consul-template_"$CT_VERS"_linux_amd64.zip

#Default nginx and consul configuration files
ENV CT_FILE /etc/consul-templates/sql.conf.ctmpl
ENV SQ_FILE /etc/user.sql

#Install Consul Template
RUN wget $CT_URL && \
    unzip -d /usr/local/bin consul-template_"$CT_VERS"_linux_amd64.zip

#Setup Consul Template Files
RUN mkdir /etc/consul-templates
COPY sql.conf.ctmpl $CT_FILE

ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
