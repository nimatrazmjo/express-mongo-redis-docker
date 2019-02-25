node {
 
    stage 'Checkout'
        checkout scm
    stage 'Build & UnitTest'
        sh "docker build -t docker-node:B${BUILD_NUMBER} -f Dockerfile ."
    
    // stage 'Pusblish UT Reports'
    //     containerID = sh (
    //         script: "docker run -d docker-node:B${BUILD_NUMBER}", 
    //     returnStdout: true
    //     ).trim()
    //     echo "Container ID is ==> ${containerID}"
    //     sh "docker stop ${containerID}"
    //     sh "docker rm ${containerID}"      
    stage 'Integration Test'
        sh "IMAGE_NAME_TAG =docker-node:B${BUILD_NUMBER}  docker-compose up --force-recreate --abort-on-container-exit"
}