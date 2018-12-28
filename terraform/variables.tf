variable "service_file" {
  default = "service-account.json"
}

variable "k8s_project" {
  default = "test-homework"
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "cluster_name" {
  default = "challenge"
}

variable "oauth_scopes" {
  default = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/devstorage.read_write",
    "https://www.googleapis.com/auth/devstorage.full_control",
  ]
}
