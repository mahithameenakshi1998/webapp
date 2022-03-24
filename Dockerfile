FROM ubuntu
LABEL Maintainer=chiranjeevi Email=rchiranjeevi36@gmail.com
RUN apt update -y
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat10/webapps
COPY /var/lib/jenkins/workspace/webapp-ci-cd-pipeline/target/*.war /opt/tomcat/webapps/WebApp.war
EXPOSE 8080
ENTRYPOINT ["/opt/tomcat/bin/catalina.sh", "run"]
