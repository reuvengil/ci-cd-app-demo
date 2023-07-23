/*
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
  namespace: production
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ci-cd-app
      version: v1
  template:
    metadata:
      labels:
        app: ci-cd-app
        version: v1
        istio: monitor
    spec:
      containers:
        - image: giler053/ci-cd-app-test:latest
          imagePullPolicy: Always
          name: ci-cd-app
          env:
            - name: PORT
              value: "8080"
          ports:
            - name: http
              containerPort: 8080
          readinessProbe:
            httpGet:
              path: /health
              port: http
            initialDelaySeconds: 5
            periodSeconds: 10
________________________
kubectl apply
*/
resource "kubernetes_deployment" "my-deployment" {
  wait_for_rollout = true
  metadata {
    name      = "my-deployment"
    namespace = "production"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "ci-cd-app"
        version = "v1"
      }
    }

    template {
      metadata {
        labels = {
          app                       = "ci-cd-app"
          version                   = "v1"
          istio                     = "monitor"
          "sidecar.istio.io/inject" = true
        }
      }

      spec {
        container {
          image = "giler053/ci-cd-app-test:latest"

          name = "ci-cd-app"

          port {
            name           = "http"
            container_port = 8080
          }

          env {
            name  = "PORT"
            value = "8080"
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = "http"
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "null_resource" "kubectl" {
  # Make rollout Every time
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = "kubectl rollout restart deployment my-deployment -n production"
    interpreter = ["/bin/bash", "-c"]
  }
}
