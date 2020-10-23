resource "aws_appmesh_virtual_service" "service-b" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "service-b"
  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.service-b-router.name
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "service-b-router" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "service-b-router"
  spec {
    listener {
      port_mapping {
        port = 80
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_route" "service-b-route" {
  name = "service-b-route"
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  virtual_router_name = aws_appmesh_virtual_router.service-b-router.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.node-b-v1.name
          weight = 50
        }

        weighted_target {
          virtual_node = aws_appmesh_virtual_node.node-b-v2.name
          weight = 50
        }
      }
    }
  }
}

resource "aws_appmesh_route" "service-b-legacy-route" {
  name = "service-b-legacy-route"
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  virtual_router_name = aws_appmesh_virtual_router.service-b-router.name

  spec {
    http_route {
      match {
        prefix = "/legacy"
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.node-b-legacy.name
          weight = 100
        }
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node-b-v1" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-b-v1"
  spec {
    listener {
      port_mapping {
        port = 80
        protocol = "http"
      }
    }

    service_discovery {
      aws_cloud_map {
        namespace_name = aws_service_discovery_private_dns_namespace.fully-connected.name
        service_name = "node-b-v1"
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-c.name
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-d.name
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-e.name
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node-b-v2" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-b-v2"
  spec {
    listener {
      port_mapping {
        port = 80
        protocol = "http"
      }
    }

    service_discovery {
      aws_cloud_map {
        namespace_name = aws_service_discovery_private_dns_namespace.fully-connected.name
        service_name = "node-b-v2"
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-c.name
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-d.name
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-e.name
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node-b-legacy" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-b-legacy"
  spec {
    listener {
      port_mapping {
        port = 80
        protocol = "http"
      }
    }

    service_discovery {
      dns {
        hostname = "fully-connected-legacy.com"
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-c.name
      }
    }
  }
}
