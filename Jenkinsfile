pipeline {
    agent any

    environment {
        SSH_KEY = credentials('jenkins-ssh')
    }

    stages {
        stage('Run Bootstrap Script') {
            steps {
                sh './bootstrap.sh'
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
