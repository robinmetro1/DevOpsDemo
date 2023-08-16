pipeline {
    agent any
    tools {
        maven 'Maven 3.3.9' 
    }
    stages {
        stage('Build Maven'){
            steps{
                git 'https://github.com/robinmetro1/DevOpsDemo.git'
                bat "mvn -Dmaven.failure.ignore=true clean install "
            }
            post{

                success{
                    echo "success build"
                    
                }
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t eyaea/devops-demo .'
                }
            }
        }
        stage('Push image to Hub'){
            sh 'docker push eyaea/devops-demo'
        }
        stage('Deploying') {
             echo "Deploying....."
             }
        stage('test') {
             echo "tttt....."
        }
}
}

