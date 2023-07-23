/*
apiVersion: v1
kind: Service
metadata:
  name: ci-cd-app
  namespace: production
spec:
  ports:
    - name: http
      port: 8080
  selector:
    app: ci-cd-app
______________________
kubectl apply
*/

resource "kubernetes_service" "ci-cd-app" {
  metadata {
    name      = "ci-cd-app"
    namespace = "production"
  }
  spec {
    port {
      name = "http"
      port = 8080
    }
    selector = {
      app = "ci-cd-app"
    }
  }
}

