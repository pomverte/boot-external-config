#!groovy

pipeline {

  stages {

    agent {
      docker {
        image 'maven:3.5.4-jdk-8-alpine'
        args '-v $HOME/.m2:/root/.m2'
      }
    }
    stage('Build Package with Tests') {
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS', targetLocation: ''/usr/share/maven/ref/settings.xml)]) {
          sh 'mvn -B -s /usr/share/maven/ref/settings.xml clean package'
        }
      }
    }

  }

}
