pipeline {

  environment {
    registry = "deathstrock47/$REPO" //qa
    namespace = "$NAMESPACE" //qa
    port = "$PORT" //32001
    dockerImage = ""
    registryCredential = "dockerhub"
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/deathstrock/myrepo.git'
        //sh """ git checkout $BRANCH """
      }
    }
  
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
          BUILD = "$registry:$BUILD_NUMBER"
        }
      }
    }
  
    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( "" , registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Stagging') {
        steps {
          script {
            sh (sed 's/namespace: /namespace: '"$namespace"'/g' myweb.yaml)
             //sed  "s/nodePort: /nodePort: $port/ myweb.yaml"
             //sed  "s/image: /- image: $BUILD/"
            kubernetesDeploy(configs: "myweb.yaml", kubeconfigId: "mykubeconfig")
          }
        }
      }
  }
}
