pipeline {

  agent none

  environment {
    DOCKER_IMG_BASENAME = 'demo-app'
    GIT_SHORT_CHANGESET = 'latest'
  }

  parameters{
     string(name: 'COOL_PHRASE', defaultValue: 'NOTHINGCOOL', description: 'your cool sentence please')
     string(name: 'SUBMITTER', defaultValue: 'anonymous', description: 'your name please')
  }

  stages {
    stage ('Checkout code'){
      agent { label 'ssh1'}
      steps {
        checkout scm
      }
    }

    stage ('Unit tests'){
      agent { label 'ssh1'}
      steps {
        sh "mvn test"
      }
    }

    stage ('Publish tests result'){
      agent { label 'ssh1'}
      steps {
        junit '**/surefire-reports/*.xml, **/failsafe-reports/*.xml'
      }
    }

    stage ('Build the code'){
      agent { label 'ssh1'}
      steps {
      sh "mvn package"
      }
    }

    stage ('Stash artifacts'){
      agent { label 'ssh1'}
      steps {
        stash includes: 'target/**/*.jar, Dockerfile, hello-world.yml', name: 'stashedfiles'
      }
    }

    stage ('Parallel tests and build'){
      when { branch 'declarative1' }
      parallel {
        stage('smokeTests - branch A'){
          agent { label 'ssh1'}
          steps {
            sh "mvn verify -fn"
          }
        }
        stage('dockerBuilder - branch B'){
          agent { label 'jnlp1'}
          steps {
            unstash 'stashedfiles'
            sh "docker build -t ${DOCKER_IMG_BASENAME}:${GIT_SHORT_CHANGESET} ./"
          }
        }
      }
    }

    stage('staging deployment approveAndDeploy'){
      agent { label 'ssh1'}
      steps {
        script {
          timeout(time: 1, unit: 'HOURS') {
            input message: 'Should I deploy the docker image to staging ?', ok: 'VASY MGL', parameters: [string(defaultValue: '', description: '', name: 'COOL_PHRASE', trim: false)], submitter: 'Abed, Annie, deanosaure', submitterParameter: 'SUBMITTED'
          }
        }
      }
    }

    stage('launch the build MAGNITUDE ! POP POOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOP'){
      agent { label 'ssh1'}
      steps {
        script {
          @Library('admin-lib@master') _
          sleep 5
          build job: 'demoapp-staging-deployer', parameters: [string(name: 'DOCKER_IMAGE', value: 'demo-app:latest')]
          sleep 10
          approveAndDeploy("$DOCKER_IMG_BASENAME:$GIT_SHORT_CHANGESET")
        }
      }
    }
  }

  post {
   success {
      sh "echo ${SUBMITTER} APPROVED THAT SHIT and his cool phrase is $COOL_PHRASE"
    }
   failure {
    echo "go fuck yourself"
   }
  }
}
