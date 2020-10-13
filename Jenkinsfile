
node ('ssh'){
    stage('Checkout code') {
      checkout scm

      // We can set a groovy variable from a "sh" command stdout.
      // Do not forget to remove endlines with trim()
      GIT_SHORT_CHANGESET =
        sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    }

    stage('Build') {
      //tool name: 'maven3', type: 'maven'
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
      def DOCKER_IMG_BASENAME='demo-app'
      def GIT_SHORT_CHANGESET='latest'
      sh 'docker build -t ${DOCKER_IMG_BASENAME}:${GIT_SHORT_CHANGESET} ./'
    }

    stage('Activate Chuck Norris bitch'){
      chuckNorris()
    }
}
