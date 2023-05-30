resource "kubernetes_deployment" "course" {
  metadata {
    name = "course"
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
          image = "giangh14cqt/fireapp-be-course"
          name  = "course"

          port {
            container_port = 8082
          }

          env {
            name  = "DATASOURCE_URL"
            value = var.dataUrlCourse
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

resource "kubernetes_service" "course" {
  metadata {
    name = "course-example"
  }
  spec {
    selector = {
      App = kubernetes_deployment.course.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8082
      target_port = 8082
    }
    # type = "LoadBalancer"
  }
}
