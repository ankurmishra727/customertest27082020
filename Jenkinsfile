pipeline {
  
  agent any
  
    stages {
        stage('Prepare') {
            steps {
                sh "packer --version"
            }
        }
        stage('validate packer template') {
            steps {
                sh "make validate"
            }
        }
        stage('Build AMI') {
            when {
                expression { env.GIT_BRANCH == 'origin/master' }
            }
            steps {
                sh "make build"
            }
        }

        }
    }
}
