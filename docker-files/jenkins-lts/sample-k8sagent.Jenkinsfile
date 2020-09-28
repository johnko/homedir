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
              inheritFrom 'root'
              namespace 'jenkinsagent'
            }
          }
          steps {
            sh "apt update -y"
            sh "apt install -y make gcc"
            dir("build") {
              git changelog: false, poll: false, url: 'https://github.com/johnko/dwm.git'
              sh "make clean all"
            }
            sh "sleep 150"
          }
        }
        stage('1b') {
          agent {
            kubernetes {
              cloud 'kubernetes'
              inheritFrom 'root'
              namespace 'jenkinsagent'
            }
          }
          steps {
            sh "apt update -y"
            sh "apt install -y make gcc"
            dir("build") {
              git changelog: false, poll: false, url: 'https://github.com/johnko/dwmsd.git'
              sh "make clean all"
            }
            sh "sleep 150"
          }
        }
      }
    }
    stage('2') {
      agent {
        kubernetes {
          cloud 'kubernetes'
          inheritFrom 'root'
          namespace 'jenkinsagent'
        }
      }
      steps {
        sh "apt update -y"
        sh "apt install -y make gcc"
        dir("build") {
          git changelog: false, poll: false, url: 'https://github.com/johnko/dmenu.git'
          sh "make clean all"
        }
        sh "sleep 150"
      }
    }
  }
}
