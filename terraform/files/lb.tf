resource "google_compute_target_pool" "puma-cluster" {
  name = "puma-cluster"

  instances = ["${google_compute_instance.app.*.self_link}"]

  #"europe-west1-b/reddit-app2",

  health_checks = [
    "${google_compute_http_health_check.puma-port.self_link}",
  ]
}

resource "google_compute_http_health_check" "puma-port" {
  name               = "puma-port"
  request_path       = "/"
  check_interval_sec = 3
  timeout_sec        = 1
  port               = "9292"
}

resource "google_compute_forwarding_rule" "puma-lb" {
  name       = "puma-lb"
  target     = "${google_compute_target_pool.puma-cluster.self_link}"
  port_range = "9292"
}
