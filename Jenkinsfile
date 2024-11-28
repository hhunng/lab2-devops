pipeline {
    agent any

    environment {
        SONAR_CLOUD_URL = 'https://sonarcloud.io'
        SONAR_PROJECT_KEY = 'devops-group15_lab2' 
        SONAR_ORGANIZATION_NAME = 'DevOps-Group15'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'gitsshkeys', url: 'https://github.com/hhunng/lab2-devops.git'
            }
        }

        stage('SonarCloud Scan') {
            steps {
                script {
                    scannerHome = tool 'sonarQube'
                }
                withSonarQubeEnv('sonarQube') {
                    sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.organization=${SONAR_ORGANIZATION_NAME} \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=${SONAR_CLOUD_URL} \
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'SonarCloud scan completed.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for more details.'
        }
    }
}