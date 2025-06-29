pipeline {
    agent any
	
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Manohar-mattepu/test_deploy.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'manoharmattepu', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        docker build -t $IMAGE_NAME .
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f k8/deployment.yaml
                    kubectl apply -f k8/service.yaml
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed. Check the build logs for details.'
        }
        always {
            echo '📦 Build finished.'
        }
    }
}
