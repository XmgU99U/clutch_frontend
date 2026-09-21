import 'dart:convert';

import 'package:clutch/core/network/api_consumer.dart';
import 'package:clutch/core/network/response.dart';
import 'package:http/http.dart' as http;

class HttpConsumer implements ApiConsumer {
  final Map<String, String> _defaultContentType = {
    'Content-Type': 'application/json',
  };
  @override
  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final http.Response res = await http.delete(
      Uri.parse(url),
      body: body,
      headers: headers ?? _defaultContentType,
    );
    print('some request happened');
    print('status code: ${res.statusCode}\n body: ${res.body}');
    try {
      final Map<String, dynamic> jsonBody = jsonDecode(res.body);

      return Response(
        statusCode: res.statusCode,
        body: jsonBody,
        headers: res.headers,
      );
    } catch (_) {
      return Response(statusCode: res.statusCode, headers: headers);
    }
  }

  @override
  Future<Response> get(String url, {Map<String, String>? headers}) async {
    final http.Response res = await http.get(
      Uri.parse(url),
      headers: headers ?? _defaultContentType,
    );
    print('some request happened');
    print('status code: ${res.statusCode}\n body: ${res.body}');

    try {
      final Map<String, dynamic> jsonBody = jsonDecode(res.body);
      return Response(
        statusCode: res.statusCode,
        body: jsonBody,
        headers: res.headers,
      );
    } catch (_) {
      return Response(statusCode: res.statusCode, headers: headers);
    }
  }

  @override
  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final http.Response res = await http.patch(
      Uri.parse(url),
      body: body,
      headers: headers ?? _defaultContentType,
    );

    print('some request happened');
    print('status code: ${res.statusCode}\n body: ${res.body}');

    try {
      final Map<String, dynamic> jsonBody = jsonDecode(res.body);
      return Response(
        statusCode: res.statusCode,
        body: jsonBody,
        headers: res.headers,
      );
    } catch (_) {
      return Response(statusCode: res.statusCode, headers: headers);
    }
  }

  @override
  Future<Response> post(
    String url, {
    Object? body,
    Map<String, String>? headers,
  }) async {
    final http.Response res = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers ?? _defaultContentType,
    );

    print('some request happened');
    print('status code: ${res.statusCode}\n body: ${res.body}');

    try {
      final Map<String, dynamic> jsonBody = jsonDecode(res.body);
      return Response(
        statusCode: res.statusCode,
        body: jsonBody,
        headers: res.headers,
      );
    } catch (_) {
      return Response(statusCode: res.statusCode, headers: headers);
    }
  }

  @override
  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final http.Response res = await http.put(
      Uri.parse(url),
      body: body,
      headers: headers ?? _defaultContentType,
    );

    print('some request happened');
    print('status code: ${res.statusCode}\n body: ${res.body}');

    try {
      final Map<String, dynamic> jsonBody = jsonDecode(res.body);
      return Response(
        statusCode: res.statusCode,
        body: jsonBody,
        headers: res.headers,
      );
    } catch (_) {
      return Response(statusCode: res.statusCode, headers: headers);
    }
  }

  @override
  Future<Response> sendMultiPartRequest(
    String url, {
    Map<String, dynamic>? body,
    required String method,
    Map<String, String>? files,
    Map<String, String>? headers,
  }) async {
    final request = http.MultipartRequest(method, Uri.parse(url));

    if (body != null) {
      body.forEach((key, value) => request.fields[key] = value);
    }

    if (files != null) {
      files.forEach((key, value) async {
        request.files.add(await http.MultipartFile.fromPath(key, value));
      });
    }

    request.headers.addAll(headers ?? {});

    final streamResponse = await request.send();

    final res = await http.Response.fromStream(streamResponse);

    print('some request happened');
    print('status code: ${res.statusCode}\n body: ${res.body}');

    try {
      final responseBody = jsonDecode(res.body);
      return Response(
        statusCode: res.statusCode,
        body: responseBody,
        headers: res.headers,
      );
    } catch (_) {
      return Response(statusCode: res.statusCode, headers: res.headers);
    }
  }
}
