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
                    catchError(buildResult: 'SUCCESS', stageResult: 'UNSTABLE') {
                        sh """
                        docker container inspect ${CONTAINER_NAME} >/dev/null 2>&1 && (
                        docker container stop ${CONTAINER_NAME}
                        docker container rm ${CONTAINER_NAME}
                        ) || echo "Container '${CONTAINER_NAME}' does not exist."
                       """
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
