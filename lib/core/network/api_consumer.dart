import 'package:clutch/core/network/response.dart';

abstract class ApiConsumer {
  Future<Response> get(String url, {Map<String, String>? headers});

  Future<Response> post(
    String url, {
    Object? body,
    Map<String, String>? headers,
  });

  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
  Future<Response> sendMultiPartRequest(
    String url, {
    required String method,
    Map<String, String>? body,
    Map<String, String>? files,
    Map<String, String>? headers,
  });
}
