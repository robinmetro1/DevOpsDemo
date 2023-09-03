pipeline {
    agent any
    tools {
        maven 'maven-3.9.4' 
    }
     environment {
        DOCKER_IMAGE = "eyaea/devops-demo"
        DOCKER_TAG = "latest"
        DOCKER_REGISTRY = "your-docker-registry-url"
        DOCKER_CREDENTIALS_ID = 'dockerhub'
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
           stage('Chechout scm') {
            steps {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/robinmetro1/DevOpsDemo.git']])                
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build your Docker image
                    def dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}", ".")
                }
            }
        }
       
        stage('Push Docker image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CREDENTIALS_ID) {
                       def dockerImage = docker.image(env.DOCKER_IMAGE)
                        dockerImage.push(env.DOCKER_TAG)
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
           post {
                always{
                  script {
                sh 'docker logout'
                 }                }
            }
        }
    }
}
