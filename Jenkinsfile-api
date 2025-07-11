pipeline {
    agent any

    environment {
        CONTAINER_IMAGE = 'monedas-api'
        CONTAINER_NAME = 'monedas-api'
        CONTAINER_NETWORK = 'monedas_network'
        HOST_PORT = '8081'
        CONTAINER_PORT = '8080'
    }

    stages {
        stage('Compile app and build image') {
            steps {
                sh "podman build -t ${CONTAINER_IMAGE} ."
            }
        }

        stage('Verify container') {
            steps {
                sh "podman container rm -f ${CONTAINER_NAME}"
            }
        }

        stage('Ship container') {
            steps {
                sh "podman run --name ${CONTAINER_NAME} --network ${CONTAINER_NETWORK} -p ${HOST_PORT}:${CONTAINER_PORT} -d ${CONTAINER_IMAGE}"
            }
        }
    }
}
