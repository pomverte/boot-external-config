#!groovy

pipeline {

  agent none

  environment {
    RUN_UNIT_TESTS = 'true'
    ARTIFACT_ID = readMavenPom().getArtifactId()
    ARTIFACT_VERSION = readMavenPom().getVersion()
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  stages {

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

    agent {
      docker {
        image 'maven:3.5.4-jdk-8-alpine'
        args '-v $HOME/.m2:/root/.m2'
      }
    }
    stage('Build Package with Tests') {
      steps {
        configFileProvider([configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn -B -s ${MAVEN_SETTINGS} clean package'
        }
      }
    }

  }

}
