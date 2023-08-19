pipeline {
    agent any
    
    tools {
        maven 'maven-3.9.4' 
    }
    
    stages {
        stage('Build Maven') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/robinmetro1/DevOpsDemo.git']]])
                sh 'mvn clean install'
            }
            post {
                success {
                    echo "Success: Maven build completed"
                }
                failure {
                    echo "Failed: Maven build"
                }
            }
        }
        
        stage('Build Docker image') {
            steps {
                script {
                    sh"docker login docker.io -u eyaea -p Lordmehrez2022*"  
                    // Define the Docker image name and tag
                    def dockerImage = docker.build("eyaea/devops-demo:${env.BUILD_NUMBER}")
                    
                    // Optionally, you can tag the image with a different name or additional tags
                    dockerImage.tag("eyaea/devops-demo:latest")
                }
            }
            post {
                success {
                    echo "Success: Docker image built"
                }
                failure {
                    echo "Failed: Docker image build"
                }
            }
        }
        
        stage('Push image to Hub') {
            steps {
                sh 'docker push eyaea/devops-demo'
            }
            post {
                success {
                    echo "Success: Docker image pushed to registry"
                }
                failure {
                    echo "Failed: Docker image push to registry"
                }
            }
        }
        
        stage('Deploying') {
            steps {
                echo "Deploying..."
                // Add deployment steps here
            }
        }
        
        stage('Test') {
            steps {
                echo "Running tests..."
                // Add test steps here
            }
        }
    }
}
