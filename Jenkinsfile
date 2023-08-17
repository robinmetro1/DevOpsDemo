pipeline {
    agent any
    
    tools {
        maven 'Maven 3.3.9' 
    }
    
    stages {
        stage('Build Maven') {
            steps {
                git url: 'https://github.com/robinmetro1/DevOpsDemo.git'
                bat "mvn -Dmaven.failure.ignore=true clean install"
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
                    sh 'docker build -t eyaea/devops-demo .'
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
