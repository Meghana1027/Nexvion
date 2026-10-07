pipeline {
    agent any

    environment {
        IMAGE_NAME = 'nexvion'
        DOCKER_USER = 'meghanas12345'
        CONTAINER_NAME = 'nexvion-jenkins'
        HOST_PORT = '8082'
    }

    stages {

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_USER%/%IMAGE_NAME%:%BUILD_NUMBER% .'
            }
        }

        stage('Security Scan') {
            steps {
                bat '"C:\\Users\\SUPRIYA\\AppData\\Local\\Microsoft\\WinGet\\Packages\\AquaSecurity.Trivy_Microsoft.Winget.Source_8wekyb3d8bbwe\\trivy.exe" image --no-progress --exit-code 1 --severity HIGH,CRITICAL %DOCKER_USER%/%IMAGE_NAME%:%BUILD_NUMBER%'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-nexvion',
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    bat '''
                        powershell -NoProfile -Command "$env:DOCKER_PASSWORD | docker login -u $env:DOCKER_USERNAME --password-stdin"
                        if errorlevel 1 exit /b 1
                        docker push %DOCKER_USER%/%IMAGE_NAME%:%BUILD_NUMBER% || exit /b 1
                        docker logout
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                bat '''
                    docker rm -f %CONTAINER_NAME% 2>nul || exit /b 0
                    docker run -d --name %CONTAINER_NAME% -p %HOST_PORT%:80 %DOCKER_USER%/%IMAGE_NAME%:%BUILD_NUMBER%
                '''
            }
        }

        stage('Health Check') {
            steps {
                bat '''
                    powershell -NoProfile -Command "Start-Sleep -Seconds 5"
                    curl.exe -I --retry 5 --retry-delay 2 --retry-all-errors http://localhost:%HOST_PORT%
                '''
            }
        }
    }

    post {
        success {
            echo 'Nexvion CI/CD pipeline completed successfully.'
        }

        failure {
            echo 'Nexvion CI/CD pipeline failed.'
        }
    }
}
