
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
      sh 'mvn package'
      junit '**/target/surefire-reports/*.xml'
    }

    stage('Archive binaries'){
      stash includes: '**/target/*.jar', name: 'app-binaries'
    }

    stage('Integration Tests'){
      sh 'mvn verify -fn'

    }
}

node ('docker'){

    stage('Checkout code') {
      checkout scm
    }

    stage('Unarchive binaries'){
      unstash 'app-binaries'
    }

    environment {
     DOCKER_IMG_BASENAME = 'demo-app'
     GIT_SHORT_CHANGESET = 'latest'
     GIT_SHORT_CHANGESET =
       sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
   }

    stage('Set and Build image') {
      sh 'docker build -t demo-app:latest ./'
    }

    stage('Activate Chuck Norris bitch'){
      chuckNorris()
    }
}
