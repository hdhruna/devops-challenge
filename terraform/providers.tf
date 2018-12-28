provider "google-beta" {
  credentials = "${file("${var.service_file}")}"
  project     = "${var.k8s_project}"
  region      = "${var.region}"
  alias       = "k8s-project"
}

provider "google" {
  credentials = "${file("${var.service_file}")}"
  project     = "${var.k8s_project}"
  region      = "${var.region}"
  alias       = "k8s-project"
}
