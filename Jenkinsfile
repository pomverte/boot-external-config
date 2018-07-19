#!groovy

pipeline {

  agent any

  environment {
    RUN_UNIT_TESTS = 'true'
    ARTIFACT_ID = readMavenPom().getArtifactId()
    ARTIFACT_VERSION = readMavenPom().getVersion()
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  stages {

    stage('Build Package with Tests') {
      when {
        environment name: 'RUN_UNIT_TESTS', value: 'true'
      }
      agent {
        docker {
          image 'maven:3.5.4-jdk-8-alpine'
          args  '-t -u 0:0 --rm --volume ${MAVEN_SETTINGS}:/tmp/settings.xml:ro --volume /maven/.m2:/root/.m2 --volume $PWD:/workspace --workdir /workspace'
        }
      }
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn --batch-mode --settings /tmp/settings.xml clean package'
        }
      }
    }

  }

}
