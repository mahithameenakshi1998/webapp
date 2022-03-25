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
    stage('docker image') {
      steps {
        sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 034989618038.dkr.ecr.us-east-1.amazonaws.com'
        sh 'docker build -t my-dockerhub-repo .'
        sh 'docker tag my-dockerhub-repo:latest 034989618038.dkr.ecr.us-east-1.amazonaws.com/my-dockerhub-repo:latest'
        sh 'docker push 034989618038.dkr.ecr.us-east-1.amazonaws.com/my-dockerhub-repo:latest'
      }
    }
    stage('Deploy to tomcat') {
      steps {
          ansiblePlaybook credentialsId: 'ansible_id', disableHostKeyChecking: true, installation: 'ansible', inventory: '/home/ubuntu/webapp/ansible/ansi.dev', playbook: '/home/ubuntu/webapp/ansible/deploy.yml'
     }
   }
 }
}
