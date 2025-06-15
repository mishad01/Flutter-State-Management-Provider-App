class Urls {
  static final String _base = "https://crud.teamrabbil.com/api/v1";
  static final String getProduct = "$_base/ReadProduct";
  static final String createProduct = "$_base/CreateProduct";
  static String updateProduct(String id) => "$_base/UpdateProduct/$id";
  static String deleteProduct(String id) => "$_base/DeleteProduct/$id";
}
