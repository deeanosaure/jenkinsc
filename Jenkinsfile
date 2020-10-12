node {
    stage('Checkout code') {
    git 'https://github.com/deeanosaure/demoapp.git'
    }

    stage('Build') {
    tool name: 'maven3', type: 'maven'
    sh 'mvn clean install'
    }
}
