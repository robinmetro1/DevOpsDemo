pipeline {
    agent {dockerfile true}
    
    tools {
        maven 'maven-3.9.4' 
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
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
                    sh 'echo echo key = $key'
                    // Build your Docker image
                    def dockerImage = docker.build("eyaea/devops-demo:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push Docker image') {
            steps {
                 script {
                    // Log in to Docker Hub using Jenkins credentials
                    withDockerRegistry([credentialsId: 'docker-login', url: DOCKER_REGISTRY]) {
                        // Push the Docker image to the registry
                        def dockerImage = docker.image("eyaea/devops-demo:${env.BUILD_NUMBER}")
                        dockerImage.push()
                    }
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
