#!groovy

pipeline {
  
  agent {
    docker {
      image 'maven:3.5.4-jdk-8-alpine'
      args '-v $HOME/.m2:/root/.m2 -v ./settings.xml:/usr/share/maven/ref/settings.xml:ro'
    }
  }

  stages {

    stage('Build Package with Tests') {
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'cat ${MAVEN_SETTINGS} > ./settings.xml'
          sh 'mvn --batch-mode clean package'
        }
      }
    }

  }

}
