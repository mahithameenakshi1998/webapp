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
    stage('Code_quality_check') {
      steps {
        withSonarQubeEnv('sonar') {
                sh 'mvn sonar:sonar'
               // sh 'cat target/sonar/report-task.txt'
        }
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
    stage('DAST') {
      steps {
        sshagent(['zap']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.89.125 "docker run -t owasp/zap2docker-stable zap-baseline.py -t http://3.85.128.46:8080/WebApp/" || true'
        } 
      }
    }
  }
}
