FROM openshift/base-centos7
MAINTAINER Kent Brake kent@elastic.co

ENV JAVA_HOME /usr/bin/java
ENV JAVACMD /usr/bin/java


CMD ["/bin/bash"]
