#!groovy

pipeline {

  agent {
    docker {
      image 'maven:3.5.4-jdk-8-alpine'
      args '-v $HOME/.m2:/root/.m2'
    }
  }

  stages {

    stage('Build Package with Tests') {
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', targetLocation: '/settings.xml')]) {
          sh 'mvn -B -s /settings.xml clean package'
        }
      }
    }

  }

}
