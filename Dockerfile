FROM tomcat:latest
COPY /var/lib/jenkins/workspace/webapp-ci-cd-pipeline/target/*.war /opt/tomcat10/webapps/WebApp.war
