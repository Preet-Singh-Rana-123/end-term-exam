pipeline {
    agent any

    environment {
        IMAGE_NAME = "preet0001/hello-node"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Preet-Singh-Rana-123/end-term-exam.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t $IMAGE_NAME:$IMAGE_TAG .
                """
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-hub-credentials',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh """
                        echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin
                        docker push $IMAGE_NAME:$IMAGE_TAG
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                    kubectl set image deployment/hello-node \
                    hello-node=$IMAGE_NAME:$IMAGE_TAG

                    kubectl rollout status deployment/hello-node
                """
            }
        }
    }
}
