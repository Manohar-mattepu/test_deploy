pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "manoharmattepu/java-k8s-app:latest"
    }

    stages {
        stage('Build Maven App') {
            steps {
                echo "🛠 Building the application with Maven..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                echo "🐳 Building and pushing Docker image..."
                script {
                    def app = docker.build("${DOCKER_IMAGE}")
                    docker.withRegistry('', 'manoharmattepu') {
                        app.push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "☸️ Deploying to Kubernetes..."
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}
