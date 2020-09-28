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
    stage('Parallel') {
      parallel {
        // One or more stages need to be included within the parallel block.
        stage('dwm') {
          agent {
            kubernetes {
              cloud 'kubernetes'
              inheritFrom 'root'
              namespace 'jenkinsagent'
            }
          }
          options {
            warnError('Unable to build dwm.')
          }
          steps {
            sh "apt update -y"
            sh "apt install -y make gcc libx11-dev"
            dir("build") {
              git changelog: false, poll: false, url: 'https://github.com/johnko/dwm.git'
              sh "grep -v include Makefile >Makefile2"
              sh "cat Makefile2 | sed 's;nonexistant.mk;;' >Makefile"
              sh "rm Makefile2"
              sh "make clean all"
            }
            sh "sleep 150"
          }
        }
        stage('dwmsd') {
          agent {
            kubernetes {
              cloud 'kubernetes'
              inheritFrom 'root'
              namespace 'jenkinsagent'
            }
          }
          steps {
            sh "apt update -y"
            sh "apt install -y make gcc libx11-dev"
            dir("build") {
              git changelog: false, poll: false, url: 'https://github.com/johnko/dwmsd.git'
              sh "grep -v include Makefile >Makefile2"
              sh "cat Makefile2 | sed 's;nonexistant.mk;;' >Makefile"
              sh "rm Makefile2"
              sh "make LDFLAGS=-lX11 clean all"
            }
            sh "sleep 150"
          }
        }
      }
    }
    stage('dmenu') {
      agent {
        kubernetes {
          cloud 'kubernetes'
          inheritFrom 'root'
          namespace 'jenkinsagent'
        }
      }
      steps {
        sh "apt update -y"
        sh "apt install -y make gcc libx11-dev"
        dir("build") {
          git changelog: false, poll: false, url: 'https://github.com/johnko/dmenu.git'
          sh "grep -v include Makefile >Makefile2"
          sh "cat Makefile2 | sed 's;nonexistant.mk;;' >Makefile"
          sh "rm Makefile2"
          sh "make clean all"
        }
        sh "sleep 150"
      }
    }
  }
}
