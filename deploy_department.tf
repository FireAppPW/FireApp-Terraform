resource "kubernetes_deployment" "department" {
  metadata {
    name = "department"
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
          image = "giangh14cqt/fireapp-be-department"
          name  = "department"

          port {
            container_port = 8081
          }

          env {
            name  = "DATASOURCE_URL"
            value = var.dataUrlDepartment
          }

          env {
            name  = "DATASOURCE_USERNAME"
            value = var.dataSourceUsername
          }

          env {
            name  = "DATASOURCE_PASSWORD"
            value = var.datasourcePassword
          }

          env {
            name = "JWT_SECRET"
            value = var.jwtSecret
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

resource "kubernetes_service" "department" {
  metadata {
    name = "department-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.department.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8081
      target_port = 8081
    }
    # type = "LoadBalancer"
  }
}
