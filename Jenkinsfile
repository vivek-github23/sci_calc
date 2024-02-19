
pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    stages {
        stage('Build Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/vivek-github23/sci_calc.git']])
                sh 'mvn clean install'
            }
        }
         stage('Run Tests') {
            steps {
                script {
                    sh 'mvn test'
                }
            }
        }


        stage('Build docker image') {
            steps {
                script {
                    sh 'docker build -t vivekdocker23/spe_mini_project .'
                }
            }
        }

        stage('Push Docker image') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'DockerHubCreds', variable: 'Binding')]) {
                        sh 'docker login -u vivekdocker23 -p ${Binding}'
                    }
                    sh 'docker push vivekdocker23/spe_mini_project'
                }
            }
        }
        stage('Stop and Remove Existing Container') {
                    steps {
                        script {
                            // Stop and remove existing container if it exists
                             sh 'docker stop JavaContainer || true'
                            sh 'docker rm -f JavaCalculator || true'
                        }
                    }
                }

         stage('Run Ansible Playbook') {
            steps {
                script {
                    ansiblePlaybook(
                        playbook: 'deploy.yml',
                        inventory: 'inventory'
                     )
                }
            }
        }
    }
}
