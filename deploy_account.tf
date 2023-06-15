resource "kubernetes_deployment" "account" {
  metadata {
    name = "account"
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
          image = "giangh14cqt/fireapp-be-account"
          name  = "account"

          port {
            container_port = 8083
          }

          env {
            name  = "DATASOURCE_URL"
            value = var.dataUrlAccount
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

resource "kubernetes_service" "account" {
  metadata {
    name = "account-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.account.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8083
      target_port = 8083
    }
    # type = "LoadBalancer"
  }
}
