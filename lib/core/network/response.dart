class Response {
  final int statusCode;
  final Map<String, dynamic>? body;
  final Map<String, String>? headers;

  Response({required this.statusCode, this.body, this.headers});
}
