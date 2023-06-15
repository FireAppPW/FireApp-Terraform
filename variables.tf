# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
variable "databaseUrl" {}

variable "dataUrlEmergency" {}

variable "dataUrlDepartment" {}

variable "dataUrlCourse" {}

variable "dataUrlAccount" {}

variable "dataSourceUsername" {}

variable "datasourcePassword" {}

variable "vmSize" {
  default = "standard_d2_v3"
}

variable "k8sDeployCpuLimit" {
  default = "0.45"
}

variable "k8sDeployMemLimit" {
  default = "1000Mi"
}

variable "k8sDeployCpuRequest" {
  default = "0.2"
}

variable "k8sDeployMemRequest" {
  default = "100Mi"
}
