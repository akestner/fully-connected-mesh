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
