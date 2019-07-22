FROM declue/ubuntu:java11

ARG JIRA_VERSION=8.3.0
ARG JIRA_HOME=/opt/jira

RUN apt-get install -y wget

# install jira
RUN mkdir -p $JIRA_HOME
RUN wget -O $JIRA_HOME/jira_$JIRA_VERSION.bin https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-$JIRA_VERSION-x64.bin
RUN chmod +x $JIRA_HOME/jira_$JIRA_VERSION.bin
COPY jira.varfile $JIRA_HOME/jira.varfile
RUN $JIRA_HOME/jira_$JIRA_VERSION.bin -q -varfile $JIRA_HOME/jira.varfile

WORKDIR $JIRA_HOME
EXPOSE 8080

# install mysql
ARG MYSQL_VERSION=5.1.47
RUN wget -O $JIRA_HOME/connector-$MYSQL_VERSION.tar.gz https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$MYSQL_VERSION.tar.gz
RUN tar xzf $JIRA_HOME/connector-$MYSQL_VERSION.tar.gz --strip=1
RUN cp $JIRA_HOME/mysql-connector-java-$MYSQL_VERSION-bin.jar $JIRA_HOME/lib/mysql-connector-java-$MYSQL_VERSION-bin.jar

# start jira
CMD ["/opt/jira/bin/start-jira.sh", "-fg"]
COPY entrypoint.sh /opt/jira/entrypoint.sh
RUN chmod +x /opt/jira/entrypoint.sh
ENTRYPOINT ["/opt/jira/entrypoint.sh"]
