node {
    stage('Checkout code') {
      checkout scm
    }

    stage('Build') {
    tool name: 'maven3', type: 'maven'
    sh 'mvn clean install'
    }
}
