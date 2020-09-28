pipeline {
  agent none
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
          agent {
            kubernetes {
              cloud 'kubernetes'
              namespace 'jenkinsagent'
            }
          }
          steps {
            sh "echo 1a"
            sh "sleep 300"
          }
        }
        stage('1b') {
          agent {
            kubernetes {
              cloud 'kubernetes'
              namespace 'jenkinsagent'
            }
          }
          steps {
            sh "echo 1b"
            sh "sleep 150"
          }
        }
      }
    }
    stage('2') {
      agent {
        kubernetes {
          cloud 'kubernetes'
          namespace 'jenkinsagent'
        }
      }
      steps {
        sh "date"
        sh "sleep 300"
      }
    }
  }
}
