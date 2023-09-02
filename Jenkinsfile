pipeline {
    agent any
    tools {
        maven 'maven-3.9.4' 
    }
     environment {
        DOCKER_IMAGE = "eyaea/devops-demo"
        DOCKER_TAG = "v2"
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
        stage('Build Docker Image') {
            steps {
                script {
                    // Build your Docker image
                   docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}", ".")
                }
            }
        }
        stage('Push Docker image') {
            steps {
                script {
                    withCredentials([usernameColonPassword(credentialsId: 'dockerhub', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u eyaea -p ${dockerhubpwd}'

    // some block
}
                   sh 'docker push eyaza/devops-demo'

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
                  script {
                docker.logout()
                 }                }
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
