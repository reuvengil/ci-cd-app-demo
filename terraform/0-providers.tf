terraform {
  required_providers {
    k8s = {
      source  = "metio/k8s"
      version = "2022.11.21"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.0"
    }
  }

}

# export KUBE_CONFIG_PATH=~/.kube/config
provider "kubernetes" {
  config_context_cluster = "minikube"
  config_path            = "~/.kube/config"
}
provider "k8s" {
  # Configuration options
}

provider "kubectl" {
  # Configuration options
}
provider "helm" {
  # Configuration options
}
