pipeline {
  agent any

  options {
    timestamps()
    ansiColor('xterm')
    disableConcurrentBuilds()
  }

  triggers {
    // Optional: if you don't have webhooks, Jenkins can poll
    // pollSCM('H/5 * * * *')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Backend CI') {
      agent {
        docker {
          image 'python:3.11'
          args '-u 0:0'
          reuseNode true
        }
      }
      steps {
        sh '''
          python --version
          pip --version
          pip install --upgrade pip
          pip install -r backend/requirements.txt
        '''
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}
