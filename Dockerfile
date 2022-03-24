FROM alpine
COPY /var/lib/jenkins/workspace/webapp-ci-cd-pipeline/target/WebApp.war /opt/tomcat10/webapps/WebApp.war
