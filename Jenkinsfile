
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

    stage('Set and Build image') {
      sh "docker build -t demo-app:latest ./"
    }

    stage('Activate Chuck Norris bitch'){
      chuckNorris()
    }

    stage('Deploy to staging'){
      timeout(time: 1, unit: 'HOURS') {
        input 'Can we deploy the image ?'
        build job: 'demoapp-staging-deployer', parameters: [string(name: 'DOCKER_IMAGE', value: 'demo-app:latest')]
      }
    }

}
