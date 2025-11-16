pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "YOUR_ECR_ID.dkr.ecr.us-east-1.amazonaws.com/webapp-repo"
        APP_SERVER = "ubuntu@APP_SERVER_PUBLIC_IP"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/udaymanikanta/webapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t webapp-repo .
                docker tag webapp-repo:latest $ECR_REPO:latest
                '''
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION \
                | docker login --username AWS --password-stdin $ECR_REPO
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                docker push $ECR_REPO:latest
                '''
            }
        }

        stage('Deploy With Ansible') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no $APP_SERVER '
                    cd /home/ubuntu/ansible &&
                    ansible-playbook deploy.yml
                '
                '''
            }
        }
    }
}
