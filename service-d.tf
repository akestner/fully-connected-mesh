resource "aws_appmesh_virtual_service" "service-d" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "service-d"
  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.node-d.name
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node-d" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-d"
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
        service_name = "node-d"
      }
    }

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
        virtual_service_name = aws_appmesh_virtual_service.service-e.name
      }
    }
  }
}
