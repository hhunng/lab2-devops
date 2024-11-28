pipeline {
    agent any

    environment {
        SONAR_CLOUD_URL = 'https://sonarcloud.io'
        SONAR_CLOUD_TOKEN = credentials('sonartoken') 
        SONAR_PROJECT_KEY = 'devops-group15_lab2' 
        SONAR_ORGANIZATION_NAME = 'DevOps-Group15'
        GITHUB_CREDENTIALS = credentials('gitsshkeys')
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
                    sh """
                        sonar-scanner \
                        -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                        -Dsonar.organization=${SONAR_ORGANIZATION_NAME} \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=${SONAR_CLOUD_URL} \
                        -Dsonar.login=${SONAR_CLOUD_TOKEN}
                    """
                }
            }
        }
    }

    post {
        always {
            echo 'SonarCloud scan completed.'
        }
    }
}