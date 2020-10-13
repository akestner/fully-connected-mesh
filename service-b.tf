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
  name = "service-b-route-1"
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

resource "aws_appmesh_virtual_node" "node-b-v1" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-b-v1"
  spec {
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

resource "aws_appmesh_virtual_node" "node-b-v2" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-b-v2"
  spec {
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
