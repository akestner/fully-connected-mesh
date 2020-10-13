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
    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service-e.name
      }
    }
  }
}
