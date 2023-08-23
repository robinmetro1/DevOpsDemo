pipeline {
    agent any
    tools {
        maven 'maven-3.9.4' 
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout scm
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
        stage('Build Docker Image') {
            steps {
                script {
                    // Build your Docker image
                    sh 'docker build -t eyaea/devops-demo .'
                }
            }
        }
        stage('Push Docker image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                           sh 'docker push  eyaea/devops-demo '
                  
                    }
                }

            }
            post {
                 success {
                    echo "Success: docker push completed"
                }
                failure {
                    echo "Failed: Docker push failed"
                }
                always{
                    sh 'docker logout'
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
