pipeline {
  triggers {
    pollSCM '* * * * *' // every 1 min
  }
  tools {
    terraform 'Terraform'
  }
  environment {
    dockerimagename = "giler053/ci-cd-app-test:latest"
    dockerImage = ""
  }

  agent any

  stages {
    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build(dockerimagename)
        }
      }
    }
    stage('Pushing Image') {
      steps {
        withDockerRegistry([credentialsId: 'dockerHubLogin', url: '']) {
          script {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Apply Kubernetes') {
      steps {
        withKubeConfig([credentialsId: 'kubeConfig']) {
          script {
            // sh '''
            // mv $KUBECONFIG ~/.kube/config
            // export KUBE_CONFIG_PATH=~/.kube/config
            // export KUBECONFIG=$KUBE_CONFIG_PATH
            // cd ./terraform 
            // terraform init -upgrade
            // terraform apply -auto-approve
            // '''
            sh '''
            export KUBE_CONFIG_PATH=$KUBECONFIG
            cd ./terraform 
            terraform init -upgrade
            terraform apply -auto-approve
            '''
          }
        }
      }
    }
  }
}
