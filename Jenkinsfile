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
    sh "docker build -t demo-app:latest ./""
}
    stage('Smoke tests with Docker img') {
    sh "export STAGING_CONTAINER_NAME=staging-demo-app"
    sh "docker stop $STAGING_CONTAINER_NAME && docker rm -v $STAGING_CONTAINER_NAME || echo "Nothing to Clean here""
    sh "docker run --name=$STAGING_CONTAINER_NAME -d -p 20000:9000 demo-app:latest"
}

  stage('activate Chuck Norris bitch') {
    chuckNorris()
  }
}
