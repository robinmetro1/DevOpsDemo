pipeline {
    agent any
    tools {
        maven 'maven-3.9.4' 
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/robinmetro1/DevOpsDemo.git']])
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
                    def dockerImage = docker.build("eyaea/devops-demo:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push Docker image') {
                steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
    
    post {
        always {
            dockerImage.cleanup()
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
