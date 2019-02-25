node {
    // environment {
    //     COMPOSE_PROJECT_NAME = "${env.JOB_NAME}-${env.BUILD_ID}"
    // }

    stage 'Checkout' {
            checkout scm
    } 

    stage('Setup Environment') {
        sh "cp ./nginx/default.conf.example ./nginx/default.conf"
    }
        
    // stage 'Build docker' {
    //     sh "docker build -t docker-test:B${env.BUILD_NUMBER} -f Dockerfile ."
    // }
}