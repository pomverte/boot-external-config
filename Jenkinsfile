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
          sh 'cat ${MAVEN_SETTINGS} > ./settings-docker.xml'
          sh 'docker container run -t -u 0:0 --rm --volume ./settings-docker.xml:/usr/share/maven/ref/settings-docker.xml:ro --volume /maven/.m2:/root/.m2 --volume $PWD:/workspace --workdir /workspace maven:3.5.4-jdk-8-alpine mvn --batch-mode --settings /usr/share/maven/ref/settings-docker.xml clean package'
        }
      }
    }

  }

}
