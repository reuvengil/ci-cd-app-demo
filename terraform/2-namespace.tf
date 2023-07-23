/*
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    istio-injection: enabled
________________________
kubectl apply
*/
resource "kubernetes_namespace" "production" {
  metadata {
    name = "production"

    labels = {
      istio-injection = "enabled"
    }
  }
}

