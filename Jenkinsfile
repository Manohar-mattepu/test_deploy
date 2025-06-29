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
            withCredentials([usernamePassword(credentialsId: 'manoharmattepu', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                sh '''
                    docker login -u $DOCKER_USER -p $DOCKER_PASS
                    docker build -t $DOCKER_USER/java-k8s-app:latest .
                    docker push $DOCKER_USER/java-k8s-app:latest
                '''
            }
        }
    }


            stage('Deploy to Kubernetes') {
                steps {
                    sh '''
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
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
