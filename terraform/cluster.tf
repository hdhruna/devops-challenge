resource "google_container_cluster" "homework_cluster" {
  provider = "google-beta.k8s-project"

  name    = "${var.cluster_name}"
  project = "${var.k8s_project}"
  zone    = "${var.zone}"

  initial_node_count       = 1
  min_master_version       = "${var.cluster_version}"
  remove_default_node_pool = true
}

resource "google_container_node_pool" "client_pool" {
  provider = "google-beta.k8s-project"

  name               = "node_pool"
  cluster            = "${google_container_cluster.homework_cluster.name}"
  zone               = "${var.zone}"
  initial_node_count = 1
  version            = "${var.cluster_version}"

  node_config {
    machine_type = "n1-highcpu-2"
    disk_size_gb = "50"
    oauth_scopes = "${var.oauth_scopes}"
    preemptible  = true

    labels = {
      load = "client"
    }

    taint = [
      {
        key    = "dedicated"
        value  = "server"
        effect = "NO_SCHEDULE"
      },
    ]
  }

  timeouts {
    create = "10m"
  }
}

resource "google_container_node_pool" "server_pool" {
  provider = "google-beta.k8s-project"

  name               = "node-pool"
  cluster            = "${google_container_cluster.homework_cluster.name}"
  zone               = "${var.zone}"
  initial_node_count = 1
  version            = "${var.cluster_version}"

  node_config {
    machine_type = "n1-standard-2"
    disk_size_gb = "50"
    oauth_scopes = "${var.oauth_scopes}"
    preemptible  = true

    labels = {
      load = "server"
    }

    taint = [
      {
        key    = "dedicated"
        value  = "server"
        effect = "NO_SCHEDULE"
      },
    ]
  }

  timeouts {
    create = "3m"
  }
}
