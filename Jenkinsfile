pipeline {

  environment {
    registry = "deathstrock47/$REPO" //qa
    namespace = "$NAMESPACE" //qa
    port = "$PORT" //32001
    dockerImage = ""
    registryCredential = "dockerhub"
  }

  agent any {

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/deathstrock/cicd.git'
        sh "git checkout $BRANCH "
      }
    }
    
    stage('Build and push') {
      steps {
        script {
          sh "cd $BRANCH"
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          //BUILD = "$registry:$BUILD_NUMBER"
          docker.withRegistry( "" , registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Deploy Canary') {
      // Canary branch
      when { branch 'canary' }
      steps {
        kubernetesDeploy(configs: "canary/myweb.yaml", kubeconfigId: "mykubeconfig")
      }
    }
    stage('Deploy Production') {
      // Production branch
      when { branch 'master' }
      steps{
        kubernetesDeploy(configs: "production/myweb.yaml", kubeconfigId: "mykubeconfig")
      }
    }
    stage('Deploy Dev') {
      // Developer Branches
      when {
        not { branch 'master' }
        not { branch 'canary' }
      }
      steps {
        kubernetesDeploy(configs: "staging/myweb.yaml", kubeconfigId: "mykubeconfig")

      }
    }
  }
}
}
