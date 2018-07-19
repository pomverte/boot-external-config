#!groovy

pipeline {
  
  agent {
    docker {
      image 'maven:3.5.4-jdk-8-alpine'
      args '-v $HOME/.m2:/root/.m2 -v ${MAVEN_SETTINGS}:/usr/share/maven/ref/settings.xml:ro'
    }
  }

  stages {

    stage('Build Package with Tests') {
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn --batch-mode clean package'
        }
      }
    }

  }

}
