pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'monedas-api'
        CONTAINER_NAME = 'monedas-api'
        DOCKER_NETWORK = 'monedas_network'
        HOST_PORT = '8081'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Compile app and build image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Verify container') {
            steps {
                script {
                        sh "docker container rm -f ${CONTAINER_NAME}"
                }
            }
        }
    }

        stage('Ship container') {
            steps {
                sh "docker run --name ${CONTAINER_NAME} --network ${DOCKER_NETWORK} -p ${HOST_PORT}:${CONTAINER_PORT} -d ${DOCKER_IMAGE}"
            }
        }
}
}
