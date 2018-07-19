pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }
  stages {
    stage('Information') {
      steps {
        echo "Hello Jenkins"
      }
    }
  }
}
