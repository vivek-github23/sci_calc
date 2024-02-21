pipeline {
    agent any

    tools {
        maven "MAVEN"
        jdk "JDK"
        git "Default"
    }
    environment {
         DOCKER_IMAGE_NAME = 'spe_mini_project'
         GITHUB_REPO_URL = 'https://github.com/vivek-github23/sci_calc.git'
    }

    stages {
          stage('Checkout') {
            steps {
                script {
                    // Checkout the code from the GitHub repository
                    git branch: 'master', url: "${GITHUB_REPO_URL}"
                }
            }
        }

        stage('Build and Test') {
            steps {
                script {
	                sh 'mvn clean package' 
        	        sh 'mvn test'
         
                }
            
             }
        }
     stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build("${DOCKER_IMAGE_NAME}", '.')
                }
            }
        }
        stage('Push Docker Images') {
            steps {
                script{
                    docker.withRegistry('', 'DockerHubCred') {
                    sh 'docker tag spe_mini_project  vivekdocker2309/spe_mini_project:latest'
                    sh 'docker push vivekdocker2309/spe_mini_project'
                    }
                 }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                script {
                    ansiblePlaybook(
                        playbook: 'ansi.yml',
                        inventory: 'inventory'
                     )
                }
            }
        }
    
       
     }
    }    
    

