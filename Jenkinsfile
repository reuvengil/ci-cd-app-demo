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
            sh '''
            mv $KUBECONFIG ~/.kube/config
            export KUBE_CONFIG_PATH=~/.kube/config
            export KUBE_LOAD_CONFIG_FILE = ~/.kube/config
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
