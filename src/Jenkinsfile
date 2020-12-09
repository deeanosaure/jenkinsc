node('ssh1') {
    stage('Checkout code') {
    checkout scm
}
    stage('Build') {
    sh "mvn clean install"
}
    stage('Activate Chuck Norris') {
    chuckNorris()
}

}
