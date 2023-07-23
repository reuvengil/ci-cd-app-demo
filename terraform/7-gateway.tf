/*
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: api
  namespace: production
spec:
  selector:
    istio: gateway
  servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
      hosts:
        - app.devopsbyexample.com
*/
resource "k8s_networking_istio_io_gateway_v1beta1" "my-gateway" {
  metadata = {
    name      = "api"
    namespace = "production"
  }
  spec = {
    selector = {
      istio = "gateway"
    }
    servers = [{
      port = {
        number   = 80
        name     = "http"
        protocol = "HTTP"
      }
      hosts = [
        "app.devopsbyexample.com"
      ]
    }]
  }
  depends_on = [kubernetes_namespace.production]
}
# kubectl apply
resource "kubectl_manifest" "my-gateway-gateway" {
  yaml_body = k8s_networking_istio_io_gateway_v1beta1.my-gateway.yaml
}
