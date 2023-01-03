FROM ghcr.io/declue/docker_ubuntu:20.04

MAINTAINER bkperio@gmail.com

# install default package
ARG DEBIAN_FRONTEND=noninteractive

# install java
RUN apt-get install -y openjdk-11-jre

# install jira software
ARG JIRA_VERSION
ENV JIRA_HOME_PATH=/var/atlassian/jira
ENV JIRA_INSTALL_PATH=/opt/jira
ENV JIRA_SYSTEM_ARCH=x64
ENV JIRA_INSTALL_FILE=atlassian-jira-software-$JIRA_VERSION-$JIRA_SYSTEM_ARCH.bin
ENV JIRA_DOWNLOAD_URL=https://www.atlassian.com/software/jira/downloads/binary

RUN mkdir -p $JIRA_INSTALL_PATH
RUN wget -O $JIRA_INSTALL_PATH/$JIRA_INSTALL_FILE $JIRA_DOWNLOAD_URL/$JIRA_INSTALL_FILE
RUN chmod +x $JIRA_INSTALL_PATH/$JIRA_INSTALL_FILE
COPY jira.varfile $JIRA_INSTALL_PATH/jira.varfile
RUN $JIRA_INSTALL_PATH/$JIRA_INSTALL_FILE -q -varfile $JIRA_INSTALL_PATH/jira.varfile

# install mysql-jdbc connector
ARG MYSQL_VERSION
ENV MYSQL_DOWNLOAD_URL=https://dev.mysql.com/get/Downloads/Connector-J
ENV MYSQL_DOWNLOAD_FILE=mysql-connector-j-$MYSQL_VERSION.tar.gz
ENV MYSQL_CONNECTOR_FILE=mysql-connector-j-$MYSQL_VERSION.jar 

RUN wget -O $JIRA_INSTALL_PATH/$MYSQL_DOWNLOAD_FILE $MYSQL_DOWNLOAD_URL/$MYSQL_DOWNLOAD_FILE
RUN tar xzf $JIRA_INSTALL_PATH/$MYSQL_DOWNLOAD_FILE --strip=1
RUN mv $MYSQL_CONNECTOR_FILE  $JIRA_INSTALL_PATH/lib/$MYSQL_CONNECTOR_FILE

# set entrypoint
COPY entrypoint.sh $JIRA_INSTALL_PATH/entrypoint.sh
RUN chmod +x $JIRA_INSTALL_PATH/entrypoint.sh

# create user
ENV JIRA_USER=jira
ENV JIRA_GROUP=jira
ENV CONTAINER_UID=1000

#RUN adduser --uid $CONTAINER_UID --system --home /home/$JIRA_USER --shell /bin/bash $JIRA_USER
RUN mkdir -p $JIRA_HOME_PATH
RUN chown -R $JIRA_USER:$JIRA_GROUP $JIRA_HOME_PATH
RUN chown -R $JIRA_USER:$JIRA_GROUP $JIRA_INSTALL_PATH

# start jira
WORKDIR $JIRA_HOME_PATH
EXPOSE 8080
USER $JIRA_USER

CMD ["/opt/jira/bin/start-jira.sh", "-fg"]
ENTRYPOINT ["/opt/jira/entrypoint.sh"]]
