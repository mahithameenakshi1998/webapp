FROM tomcat:latest
WORKDIR /opt/tomcat10/webapps
COPY target/*.war /opt/tomcat10/webapps/WebApp.war
EXPOSE 8080
