pipeline {
    agent any

    environment {
        SSH_KEY = credentials('jenkins-ssh')
    }

    stages {
        stage('Run Bootstrap Script') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key-id', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-access-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]){
                    sh 'chmod +x bootstrap.sh'
                    sh './bootstrap.sh'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}


