pipeline {
  agent any
  tools {
    maven 'maven-3.8.4'
  }
  stages {
    stage('Initialize') {
        steps {
           sh '''
              echo "PATH=${PATH}"
              echo "M2_HOME=${M2_HOME}"
              '''
        }
    }
    stage('check git secrets') {
      steps {
        sh 'rm trufflehog || true'
        sh 'docker run gesellix/trufflehog https://github.com/chiranjeevi36/webapp.git > trufflehog'
        sh 'cat trufflehog'
      }
    }
    stage('source composition analysis') {
      steps {
        sh 'rm owasp* || true'
        sh 'wget https://raw.githubusercontent.com/chiranjeevi36/webapp/master/owasp-dependency-check.sh'
        sh 'chmod +x owasp-dependency-check.sh'
        sh 'bash owasp-dependency-check.sh'
      }
    }
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Deploy to tomcat') {
      steps {
sshagent(['tomcat']) {
    sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/webapp-ci-cd-pipeline/target/*.war ubuntu@172.31.89.218:/opt/tomcat10/webapps/WebApp.war'
       }
     }
   }
 }
}
