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
    stage('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Deploy to tomcat') {
      steps {
sshagent(['tomcat']) {
    sh 'scp ssh -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/webapp-ci-cd-pipeline/target/*.war ubuntu@172.31.89.218:/opt/tomcat10/webapps/WebApp.war'
       }
     }
   }
 }
}
