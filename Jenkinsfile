pipeline {
    agent any

    environment {
        DOCKER_REGISTRY_USER  = 'preet0001'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages {
        stage("Clone Git Repo") {
            steps {
                git url: 'https://github.com/Preet-Singh-Rana-123/end-term-exam', branch: 'main'
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "docker build -t ${DOCKER_REGISTRY_USER}/end-term-app:latest ."
            }
        }

        stage("Push to Docker Hub") {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    sh "echo '${DOCKER_PASS}' | docker login -u '${DOCKER_USER}' --password-stdin"
                    sh "docker push ${DOCKER_REGISTRY_USER}/end-term-app:latest"
                }
            }
        }

        stage("Deploy to Kubernetes") {
            steps {
                sh """
                    kubectl apply -f k8s/deployment.yml
                    kubectl set image deployment/my-container-app web-app=${DOCKER_REGISTRY_USER}/end-term-app:latest
                    kubectl rollout status deployment/my-container-app
                """
            }
        }
    }
}
