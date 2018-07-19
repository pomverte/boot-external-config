pipeline {
  
  agent any
  
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
    
  }
  
}
