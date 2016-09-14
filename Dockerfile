FROM openshift/base-centos7
MAINTAINER Kent Brake kent@elastic.co

ENV JAVA_HOME /usr/bin/java
ENV JAVACMD /usr/bin/java

# Repos
ADD repo/elasticsearch.repo /etc/yum.repos.d/
ADD repo/logstash.repo /etc/yum.repos.d/
ADD repo/kibana.repo /etc/yum.repos.d/
ADD repo/filebeat.repo /etc/yum.repos.d/
ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

# Install Packages
RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
# RUN yum update -y
RUN yum install -y pkgconfig initscripts elasticsearch wget java-1.8.0-openjdk hostname which
RUN mkdir -p /usr/share/elasticsearch/logs


ADD conf/elasticsearch.yml /usr/share/elasticsearch/config/
ADD conf/logging.yml /usr/share/elasticsearch/config/
ADD conf/supervisord.conf /etc/supervisord.conf

# Expose volumes
RUN mkdir /data && touch /data/x
RUN mkdir -p /data/supervisord/log
RUN chown -R elasticsearch:elasticsearch /data
VOLUME ["/data"]
EXPOSE 5601

ENV PATH=$PATH:/usr/share/elasticsearch/bin
ENV ES_HOME=/usr/share/elasticsearch

CMD ["elasticsearch"]
