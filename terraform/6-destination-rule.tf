/*
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: ci-cd-app
  namespace: production
spec:
  host: ci-cd-app
  subsets:
    - name: v1
      labels:
        app: ci-cd-app
        version: v1
*/
resource "k8s_networking_istio_io_destination_rule_v1beta1" "ci-cd-app" {
  metadata = {
    name      = "ci-cd-app"
    namespace = "production"
  }
  spec = {
    host = "ci-cd-app"

    subsets = [{
      name = "v1"
      labels = {
        app     = "ci-cd-app"
        version = "v1"
      }
    }]
  }
}

# kubectl apply
resource "kubectl_manifest" "ci-cd-app-destinationrule" {
  yaml_body = k8s_networking_istio_io_destination_rule_v1beta1.ci-cd-app.yaml
}


