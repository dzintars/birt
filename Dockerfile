FROM ubuntu:18.04

#Update
RUN apt-get update
RUN apt-get -y upgrade

#Pre-Installation
RUN apt -y install openjdk-8-jdk
RUN apt -y install wget
RUN wget "https://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz" -P /opt/tomcat
RUN tar xzvf /opt/tomcat/apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1

RUN apt -y install unzip
RUN wget "http://download.eclipse.org/birt/downloads/drops/R-R1-4.8.0-201806261756/birt-runtime-4.8.0-20180626.zip" -P /opt/tomcat/webapps
RUN unzip "/opt/tomcat/webapps/birt-runtime-4.8.0-20180626.zip" -d /opt/tomcat/webapps/birt-runtime
RUN mv "/opt/tomcat/webapps/birt-runtime/WebViewerExample" "/opt/tomcat/webapps/birt"
RUN rm /opt/tomcat/webapps/birt-runtime-4.8.0-20180626.zip
RUN rm -f -r "/opt/tomcat/webapps/birt-runtime"

#RUN mkdir /usr/share/tomcat && mkdir /etc/tomcat
RUN cd /opt/tomcat && ln -s /etc/tomcat conf

# RUN cd /opt/tomcat && ln -s /etc/tomcat conf
# RUN ln -s /opt/tomcat/webapps/ /usr/share/tomcat/webapps

#Add JDBC

RUN wget "http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.15.tar.gz" -P /opt/tomcat/webapps/birt/WEB-INF/lib
RUN tar xzvf "/opt/tomcat/webapps/birt/WEB-INF/lib/mysql-connector-java-8.0.15.tar.gz" -C /opt/tomcat/webapps/birt/WEB-INF/lib/ --strip-components=1 mysql-connector-java-8.0.15/mysql-connector-java-8.0.15.jar

# Map Reports folder
VOLUME /opt/tomcat/webapps/birt/reports
VOLUME /opt/tomcat/webapps/birt

# Modify birt viewer setting for reports path issue
RUN perl -i -p0e "s/BIRT_VIEWER_WORKING_FOLDER<\/param-name>\n\t\t<param-value>/BIRT_VIEWER_WORKING_FOLDER<\/param-name>\n\t\t<param-value>\/opt\/tomcat\/webapps\/birt\//smg" /opt/tomcat/webapps/birt/WEB-INF/web.xml

#Start
CMD /opt/tomcat/bin/catalina.sh run
# CMD ["catalina.sh", "run"]

#Port
EXPOSE 8080