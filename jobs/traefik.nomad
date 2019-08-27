job "traefik" {
  datacenters = ["dc1"]
  type = "service"

  group "loadbalancers" {
    count = 1

    task "traefik" {
      driver = "docker"

      config {
        image = "traefik:1.7.12"
        network_mode = "host"

        args = [
          "--api",
          "--consulcatalog",
          "--consulcatalog.endpoint=${attr.unique.network.ip-address}:8500",
          "--consulcatalog.frontEndRule=''",
          "--consulcatalog.exposedByDefault=false"
        ]

        port_map {
          http = 80
          ui = 8080
        }
      }

      resources {
        network {
          port "http" { static = 80 }
          port "ui" { static = 8080 }
        }

        memory = 50
      }

      service {
        name = "traefik"
        port = "http"
      }

    }
  }
}
