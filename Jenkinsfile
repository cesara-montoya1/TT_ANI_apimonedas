pipeline {
    agent any

    environment {
        CONTAINER_IMAGE = 'monedas-api'
        CONTAINER_NAME = 'monedas-api'
        CONTAINER_NETWORK = 'monedas_network'
        HOST_PORT = '8081'
        CONTAINER_PORT = '8080'

        // Database specific environment variables
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
    }

    stages {
        stage('Ensure network') {
            steps {
                script {
                    // --- ADDED THIS LINE FOR DEBUGGING XDG_RUNTIME_DIR ---
                    sh "echo $XDG_RUNTIME_DIR"
                    sh "podman network rm -f ${CONTAINER_NETWORK}"
                    sh "podman network create ${CONTAINER_NETWORK}"
                }
            }
        }

        stage('Prepare DB') {
            steps {
                sh "podman-compose -f ${DOCKER_COMPOSE_FILE} up -d"
            }
        }

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
