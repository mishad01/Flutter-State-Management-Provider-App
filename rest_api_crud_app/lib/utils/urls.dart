class Urls {
  static final String _baseUrl = "https://crud.teamrabbil.com/api/v1";
  static String getProduct = "$_baseUrl/ReadProduct";
  static String createProduct = "$_baseUrl/CreateProduct";
  static String updateProduct(String id) => "$_baseUrl/UpdateProduct/$id";
  static String deleteProduct(String id) => "$_baseUrl/DeleteProduct/$id";
}
