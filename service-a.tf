resource "aws_appmesh_virtual_service" "service-a" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "service-a"
  spec {
    provider {
      virtual_node {
        virtual_node_name = aws_appmesh_virtual_node.node-a.name
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node-a" {
  mesh_name = aws_appmesh_mesh.fully-connected-mesh.name
  name = "node-a"
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

    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-e.name
      }
    }
  }
}
