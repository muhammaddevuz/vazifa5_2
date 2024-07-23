const String createProduct = """
mutation addProduct(\$title: String!, \$price: Float!, \$description: String!, \$categoryId: Float!, \$images: [String!]!){
  addProduct(data: {title: \$title, price: \$price, description: \$description, categoryId: \$categoryId, images: \$images}){
    id
    title
    price
    description
    images
    category{
    name
    }
    
  }
}
""";

const String updateProduct = """
mutation updateProduct(\$id: ID!, \$title: String!, \$price: Float!, \$description: String!, \$images: [String!]!) {
  updateProduct(id: \$id, changes: {title: \$title, price: \$price, description: \$description, images: \$images}) {
    id
    title
    price
    description
    images
  }
}
""";

const String editProduct = """
mutation editProduct(
    \$id: ID!, 
    \$title: String!, 
    \$price: Float!, 
    \$description: String!,
) {
    updateProduct(
      id: \$id
      changes: {
        title: \$title
        price: \$price
        description: \$description
      }
    ) {
      id
      title
      price
    }
}
""";

const String deleteProduct = """
mutation deleteProduct(\$id: ID!){
  deleteProduct(id: \$id)
}
""";
