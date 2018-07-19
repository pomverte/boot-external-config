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

    stage('Build Package') {
      when {
        environment name: 'RUN_UNIT_TESTS', value: 'true'
      }
      steps {
        dockerContainerRunMaven 'clean package'
      }
      when {
        not { environment name: 'RUN_UNIT_TESTS', value: 'true' }
      }
      steps {
        dockerContainerRunMaven 'clean package -DskipTests'
      }
    }

  }
  
}
