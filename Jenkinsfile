def DOCKER_IMG_BASENAME='demo-app'
def GIT_SHORT_CHANGESET='latest'

node('ssh1') {
    stage('Checkout code') {
      checkout scm
    }
    stage('Build') {
      sh "mvn clean install"
    }
    stage('Stash artifacts') {
      stash includes: 'target/**/*.jar, Dockerfile, hello-world.yml', name: 'stashedfiles'
      }
}


node('jnlp1') {
    stage('Unstash artifacts') {
      unstash 'stashedfiles'
    }
    stage('Build docker image') {
      sh "docker build -t ${DOCKER_IMG_BASENAME}:${GIT_SHORT_CHANGESET} ./"
      }
    stage('activate Chuck Norris bitch') {
      chuckNorris()
    }
}
