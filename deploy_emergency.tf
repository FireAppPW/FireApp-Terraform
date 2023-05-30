resource "kubernetes_deployment" "emergency" {
  metadata {
    name = "emergency"
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
          image = "giangh14cqt/fireapp-be-emergency"
          name  = "emergency"

          port {
            container_port = 8084
          }

          env {
            name  = "DATASOURCE_URL"
            value = var.dataUrlEmergency
          }

          env {
            name  = "DATASOURCE_USERNAME"
            value = var.dataSourceUsername
          }

          env {
            name  = "DATASOURCE_PASSWORD"
            value = var.datasourcePassword
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

resource "kubernetes_service" "emergency" {
  metadata {
    name = "emergency-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.emergency.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8084
      target_port = 8084
    }
    # type = "LoadBalancer"
  }
}
