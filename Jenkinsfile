pipeline {
    agent any

    environment {
        SSH_KEY = credentials('jenkins-ssh')   // your PEM from Jenkins credentials
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'ITA710',
                    url: 'https://github.com/shivankiB/DevOps_Assignment.git'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Configure Infrastructure with Ansible') {
            steps {
                dir('ansible') {
                    sh '''
                    ansible-playbook -i inventory.ini playbook.yml \
                    --private-key ~/.ssh/terraform-key.pem -u ubuntu
                    '''
                }
            }
        }

        stage('Deploy Docker Stack') {
            steps {
                dir('django_app') {
                    sh '''
                    docker stack deploy -c docker-compose.yml myapp
                    docker service ls
                    '''
                }
            }
        }

        stage('Post-Deployment Verification') {
            steps {
                sh 'curl -I http://localhost:8000 || true'
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
