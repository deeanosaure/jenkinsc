def DOCKER_IMG_BASENAME='demo-app'
def GIT_SHORT_CHANGESET='latest'

node('ssh1') {
    stage('Checkout code') {
      checkout scm
    }
    stage('Unit tests') {
      sh "mvn test"
    }
    stage('Publish tests result') {
      junit '**/surefire-reports/*.xml, **/failsafe-reports/*.xml'
    }
    stage('Build the code') {
      sh "mvn package"
    }
    stage('Smoke tests') {
      sh "mvn verify"
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

stage('deploy to staging ?') {
  timeout(time: 1, unit: 'HOURS') {
      input message: 'Should I deploy the docker image to staging ?', ok: 'VASY MGL', parameters: [string(defaultValue: '', description: '', name: 'COOL_PHRASE', trim: false)], submitter: 'Abed, Annie, deanosaure', submitterParameter: 'SUBMITTED'
    }
}

stage('launch the build MAGNITUDE !') {
  sh " echo Deployment has been approved "
  sleep 5
  sh " POP POOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOP "
  sh "echo ${SUBMITTER} APPROVED THAT SHIT and his cool phrase is ${COOL_PHRASE}"
  build job: 'demoapp-staging-deployer', parameters: [string(name: 'DOCKER_IMAGE', value: '${DOCKER_IMG_BASENAME}:${GIT_SHORT_CHANGESET}')]
}

stage('Re activate Chuck Norris bitchhhhhhhhhhhhhhh') {
  chuckNorris()
}
