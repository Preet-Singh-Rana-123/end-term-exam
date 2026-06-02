pipleline{
    agent any

    environment {
        DOCKER_REGISTRY_USER = 'preet0001'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials'
    }

    stages{
        stage("clone git repo"){
            steps{
                sh "git clone https://github.com/Preet-Singh-Rana-123/end-term-exam"
            }
        }
    }
    stages{
        stage("build docker image"){
            steps{
                sh "docker build preet0001/end-term-app ."
                sh "docker tag preet0001/end-term-app preet0001/end-term-app:latest"
            }
        }
    }
    stages{
        stage("push to docke hub"){
            steps{
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                sh "echo '${DOCKER_PASS}' | docker login -u 'preet0001' --password-stdin"
                sh "docker push preet0001/end-term-app:latest"
            }
        }
    }
    stages{
        stage("deploy to kubernetes"){
            steps{
                sh """
                        kubectl apply -f k8s/deployment.yml
                        kubectl set image deployment/my-container-app web-app=preet0001/end-term-app:latest
                        kubectl rollout status deployment/my-container-app
                    """
            }
        }
    }
}
