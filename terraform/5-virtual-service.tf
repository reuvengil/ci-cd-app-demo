/*
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: ci-cd-app
  namespace: production
spec:
  hosts:
    - app.devopsbyexample.com 
    - ci-cd-app
  gateways:
    - api
  http:
    - match:
        - uri:
            prefix: /
      route:
        - destination:
            host: ci-cd-app
            subset: v1
          weight: 100
*/

resource "k8s_networking_istio_io_virtual_service_v1beta1" "ci-cd-app" {
  metadata = {
    name      = "ci-cd-app"
    namespace = "production"
  }
  spec = {
    hosts = [
      "app.devopsbyexample.com",
      "ci-cd-app",
    ]

    gateways = [
      "api"
    ]

    http = [{
      match = [{
        uri = {
          prefix = "/"
        }
      }]
      route = [{
        destination = {
          host   = "ci-cd-app"
          subset = "v1"
        }
        weight = 100
      }]
    }]
  }
}
# kubectl apply
resource "kubectl_manifest" "ci-cd-app-virtualservice" {
  yaml_body = k8s_networking_istio_io_virtual_service_v1beta1.ci-cd-app.yaml
}
