pipeline {
  agent {
    kubernetes {
      cloud 'kubernetes'
      namespace 'jenkinsagent'
    }
  }
  options {
    buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '365', numToKeepStr: '')
    disableConcurrentBuilds()
    skipDefaultCheckout true
    timeout(time: 12, unit: 'HOURS')
    timestamps()
  }
  stages {
    stage('parallel') {
      parallel {
        // One or more stages need to be included within the parallel block.
        stage('1a') {
          steps {
            sh "echo 1a"
          }
        }
        stage('1b') {
          steps {
            sh "echo 1b"
          }
        }
      }
    }
    stage('2') {
      steps {
        sh "date"
      }
    }
  }
}
