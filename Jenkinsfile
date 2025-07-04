pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "monedas-api"
        CONTAINER_NAME = "monedas-api"
        DOCKER_NETWORK = "monedas_network"
        DOCKER_BUILD_DIR = "presentacion"
        HOST_PORT = "8081"
        CONTAINER_PORT = "8080"
    }

    stages {
        stage("Build jar") {
            steps {
                sh "mvn clean package -DskipTests"
            }
        }
        stage("Build image") {
            steps {
                dir("${DOCKER_BUILD_DIR}") {
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }
        stage("Deploy container") {
            steps {
                sh "docker run --name ${CONTAINER_NAME} --network ${DOCKER_NETWORK} -p ${HOST_PORT}:${CONTAINER_PORT} -d ${DOCKER_IMAGE}"
            }
        }
    }
}
