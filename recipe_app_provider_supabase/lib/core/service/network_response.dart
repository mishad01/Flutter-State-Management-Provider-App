class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  dynamic body;
  String? errorMessage;

  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.body,
    this.errorMessage = "Something went wrong",
  });
}
