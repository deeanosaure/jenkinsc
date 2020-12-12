@Library('admin-lib@master') _

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
    stage('Stash artifacts') {
      stash includes: 'target/**/*.jar, Dockerfile, hello-world.yml', name: 'stashedfiles'
      }
}


parallel (smokeTests: {
  node('ssh1'){
    stage('smokeTests') {
      sh "mvn verify -fn"
    }
  }
}, dockerBuilder: {
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
}
)

/*
node('ssh1'){

  stage('deploy to staging ?') {
    timeout(time: 1, unit: 'HOURS') {
        input message: 'Should I deploy the docker image to staging ?', ok: 'VASY MGL', parameters: [string(defaultValue: '', description: '', name: 'COOL_PHRASE', trim: false)], submitter: 'Abed, Annie, deanosaure', submitterParameter: 'SUBMITTED'
      }
  }
  stage('launch the build MAGNITUDE ! POP POOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOP') {
    sleep 5
    build job: 'demoapp-staging-deployer', parameters: [string(name: 'DOCKER_IMAGE', value: 'demo-app:latest')]
  }

//  sh "echo ${SUBMITTER} APPROVED THAT SHIT and his cool phrase is ${COOL_PHRASE}"
}
*/

approveAndDeploy("demo-app:latest")
