class Urls {
  static const String baseUrl = 'https://crud.teamrabbil.com/api/v1';
  static const String createProduct = '$baseUrl/CreateProduct';
  static String updateProduct(String id) => '$baseUrl/UpdateProduct/$id';
  static String deleteProduct(String id) => '$baseUrl/delete-product/$id';
  static String getProducts = '$baseUrl/ReadProduct';
}
