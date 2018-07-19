#!groovy

pipeline {
  
  agent {
    docker {
      image ' maven:3.5.4-jdk-8-alpine'
      args '-t --rm --volume ${MAVEN_SETTINGS}:/usr/share/maven/ref/settings.xml --volume $HOME/.m2:/root/.m2 --volume $PWD:/workspace --workdir /workspace'
    }
  }

  stages {

    stage('Build Package with Tests') {
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn --batch-mode --settings /usr/share/maven/ref/settings-docker.xml clean package'
        }
      }
    }

  }

}
