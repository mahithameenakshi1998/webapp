FROM tomcat:latest
WORKDIR /opt/tomcat10/webapps
COPY /var/lib/jenkins/workspace/webapp-ci-cd-pipeline/target/WebApp.war /opt/tomcat10/webapps/WebApp.war
EXPOSE 8080
