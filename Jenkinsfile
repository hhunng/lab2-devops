pipeline {
    agent any

    environment {
        REGISTRY = "container-registry" 
        IMAGE_NAME = "billing-im"
        // KUBECONFIG = credentials('kubeconfig-credentials-id') // Jenkins secret for Kubeconfig
        SONAR_TOKEN = credentials('sonarcloud-token') // SonarCloud token
        SNYK_TOKEN = credentials('snyk-token') // Snyk token
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out the repository"
                checkout scm
            }
        }

        stage('Build') 
            steps {
                script {
                    echo "Building the Docker image"
                    def gitCommit = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    docker.build("${REGISTRY}/${IMAGE_NAME}:${gitCommit}")
                }
            }
        }

        stage('SonarCloud Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh '''
                    mvn sonar:sonar \
                        -Dsonar.projectKey=devops-group15_lab2 \
                        -Dsonar.organization=devops-group15 \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }
sonar-scanner \             
  -Dsonar.organization=devops-group15 \
  -Dsonar.projectKey=devops-group15_lab2 \
  -Dsonar.sources=. \
  -Dsonar.host.url=https://sonarcloud.io
        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    script {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }

        stage('Snyk Security Scan') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'snyk-token', variable: 'SNYK_TOKEN')]) {
                        sh 'snyk test --org=your-org-name --project-name=your-project-name'
                    }
                }
            }
        }

        stage('Push Image to Registry') {
            steps {
                script {
                    def gitCommit = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    docker.image("${REGISTRY}/${IMAGE_NAME}:${gitCommit}").push()
                }
            }
        }

        stage('Deploy to Dev') {
            steps {
                echo "Deploying to Dev environment"
                sh '''
                kubectl apply -f k8s/dev/deployment.yaml
                '''
            }
        }

        stage('Promote to Staging') {
            input {
                message "Approve deployment to Staging?"
            }
            steps {
                echo "Deploying to Staging environment"
                sh '''
                kubectl apply -f k8s/staging/deployment.yaml
                '''
            }
        }

        stage('Promote to Production') {
            input {
                message "Approve deployment to Production?"
            }
            steps {
                echo "Deploying to Production environment"
                sh '''
                kubectl apply -f k8s/production/deployment.yaml
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully."
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}
