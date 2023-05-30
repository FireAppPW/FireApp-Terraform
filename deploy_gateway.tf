resource "kubernetes_deployment" "gateway" {
  metadata {
    name = "gateway"
    labels = {
      App = "backend"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "backend"
      }
    }
    template {
      metadata {
        labels = {
          App = "backend"
        }
      }
      spec {
        container {
          image = "giangh14cqt/fireapp-be-gateway"
          name  = "gateway"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = var.k8sDeployCpuLimit
              memory = var.k8sDeployMemLimit
            }
            requests = {
              cpu    = var.k8sDeployCpuRequest
              memory = var.k8sDeployMemRequest
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "gateway" {
  metadata {
    name = "gateway-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.gateway.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}
