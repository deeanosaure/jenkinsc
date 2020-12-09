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
      sh "docker build -t "demo-app:latest" ./"
    }

    stage('activate Chuck Norris bitch') {
      ChuckNorris()
    }
}
