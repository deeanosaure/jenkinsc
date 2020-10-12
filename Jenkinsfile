node ('ssh'){
    stage('Checkout code') {
      checkout scm
    }

    stage('Build') {
      tool name: 'maven3', type: 'maven'
      sh 'mvn clean install'
    }

    stage('Archive binaries'){
      stash includes: '**/target/*.jar', name: 'app-binaries'
    }
}

node ('docker'){
    stage('Checkout code') {
      checkout scm
    }

    stage('Unarchive binaries'){
      unstash 'app-binaries'
    }

    stage('Set and Build image') {
      sh 'DOCKER_IMG_BASENAME="demo-app"'
      sh 'DOCKER_IMG_FULLNAME="demo-app:${GIT_COMMIT}"'
      sh 'docker build -t "${DOCKER_IMG_FULLNAME}" ./'
      sh 'docker tag "${DOCKER_IMG_FULLNAME}" "${DOCKER_IMG_BASENAME}:latest"'
    }

    stage('Run smoke tests') {
      sh 'CID="$(docker run -d -P ${DOCKER_IMG_FULLNAME})"'
      sh 'docker kill "${CID}"'
      sh 'docker rm -v "${CID}"'
    }

    stage('Activate Chuck Norris bitch'){
      chuckNorris()
    }
}
