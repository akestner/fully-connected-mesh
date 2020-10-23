resource "aws_appmesh_virtual_service" "service-c" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "service-c"
  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.node-c.name
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node-c" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-c"
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
        service_name = "node-c"
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-b.name
      }
    }

    backend {
      virtual_service {
        // have to specify service name as a string to avoid Terraform complaining about cyclic graph
        virtual_service_name = "service-d"
      }
    }

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-e.name
      }
    }
  }
}
