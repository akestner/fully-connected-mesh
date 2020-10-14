resource "aws_appmesh_virtual_service" "service-e" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "service-e"
  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.service-e-router.name
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "service-e-router" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "service-e-router"
  spec {
    listener {
      port_mapping {
        port = 80
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_route" "service-e-route" {
  name = "service-e-route"
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  virtual_router_name = aws_appmesh_virtual_router.service-e-router.name

  spec {
    http_route {
      match {
        prefix = "/"
      }

      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.node-e-v1.name
          weight = 33
        }

        weighted_target {
          virtual_node = aws_appmesh_virtual_node.node-e-v2.name
          weight = 33
        }

        weighted_target {
          virtual_node = aws_appmesh_virtual_node.node-e-v3.name
          weight = 33
        }
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node-e-v1" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-e-v1"
  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-b.name
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
  }
}

resource "aws_appmesh_virtual_node" "node-e-v2" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-e-v2"
  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-b.name
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
  }
}


resource "aws_appmesh_virtual_node" "node-e-v3" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-e-v3"
  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-b.name
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
  }
}
