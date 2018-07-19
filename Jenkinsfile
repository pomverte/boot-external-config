#!groovy

def dockerContainerRunMaven(mvnArgs){
  configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
    sh 'docker container run -t --rm --volume ${MAVEN_SETTINGS}:/tmp/settings.xml:ro --volume /maven/.m2:/root/.m2 --volume $PWD:/workspace --workdir /workspace maven:3.5.4-jdk-8-alpine mvn --batch-mode --settings /tmp/settings.xml ${mvnArgs}'
  }
}

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

    stage('Hello') {
      steps {
        echo "Hello Jenkins"
      }
    }

    stage('Information') {
      steps {
        script {
          def commit = sh(returnStdout: true, script: 'git --no-pager show -s --format=\'%h\'  origin/' + env.BRANCH_NAME).trim()
          def author = sh(returnStdout: true, script: 'git --no-pager show -s --format=\'%an\' origin/' + env.BRANCH_NAME).trim()
          def authorEmail = sh(returnStdout: true, script: 'git --no-pager show -s --format=\'%ae\' origin/' + env.BRANCH_NAME).trim()
          def comment = sh(returnStdout: true, script: 'git --no-pager show -s --format=\'%B\' origin/' + env.BRANCH_NAME).trim()
          echo """
    Branch : ${env.BRANCH_NAME}
    Author : ${author}
    Email : ${authorEmail}
    Commit : ${commit}
    Comment : ${comment}
    ArtifactId : ${ARTIFACT_ID}
    Version : ${ARTIFACT_VERSION}
          """
        }
      }
    }

    stage('Build Package with Tests') {
      when {
        environment name: 'RUN_UNIT_TESTS', value: 'true'
      }
      agent {
        docker {
          image 'maven:3.5.4-jdk-8-alpine'
          args  ' -t --rm --volume ${MAVEN_SETTINGS}:/tmp/settings.xml:ro --volume /maven/.m2:/root/.m2 --volume $PWD:/workspace --workdir /workspace'
        }
      }
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn --batch-mode --settings /tmp/settings.xml clean package'
        }
      }
    }
    stage('Build Package Skip Tests') {
      when {
        not { environment name: 'RUN_UNIT_TESTS', value: 'true' }
      }
      agent {
        docker {
          image 'maven:3.5.4-jdk-8-alpine'
          args  '-t --rm --volume ${MAVEN_SETTINGS}:/tmp/settings.xml:ro --volume /maven/.m2:/root/.m2 --volume $PWD:/workspace --workdir /workspace'
        }
      }
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn --batch-mode --settings /tmp/settings.xml clean package -DskipTests'
        }
      }
    }

  }

}
