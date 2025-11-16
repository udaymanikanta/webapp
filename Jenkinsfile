pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "webapp-repo"
        DOCKER_IMAGE = "853027285547.dkr.ecr.us-east-1.amazonaws.com/webapp-repo"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/YourUserName/YourWebAppRepo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                  docker build -t webapp-repo:latest .
                '''
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                  aws ecr get-login-password --region $AWS_REGION | \
                  docker login --username AWS --password-stdin $DOCKER_IMAGE
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                  docker tag webapp-repo:latest $DOCKER_IMAGE:latest
                  docker push $DOCKER_IMAGE:latest
                '''
            }
        }

        stage('Deploy on EC2') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no -i /home/ubuntu/devops-key.pem ubuntu@<APP_SERVER_PUBLIC_IP> << EOF
                docker stop webapp || true
                docker rm webapp || true
                docker pull $DOCKER_IMAGE:latest
                docker run -d -p 80:80 --name webapp $DOCKER_IMAGE:latest
                EOF
                '''
            }
        }
    }
}
