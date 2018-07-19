#!groovy

pipeline {

  agent any

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  stages {

    stage('Build Package with Tests') {
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'docker container run -t -u 0:0 --rm --volume ${MAVEN_SETTINGS}:/usr/share/maven/ref/settings-docker.xml --volume /tmp/.m2:/root/.m2 --volume $PWD:/workspace --workdir /workspace maven:3.5.4-jdk-8-alpine mvn --batch-mode --settings /usr/share/maven/ref/settings-docker.xml clean package'
        }
      }
    }

  }

}
