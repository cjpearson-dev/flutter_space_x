import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'api.dart';

final class ApiServiceHttp implements ApiService {
  // Would have this in an .env file if it wasn't a publicly accessible API.
  final _baseUrl = 'https://api.spacexdata.com/v3';

  // CREATE
  @override
  Future<ApiResponse> post({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) {
    // TODO: implement post
    throw UnimplementedError();
  }

  // READ
  @override
  Future<ApiResponse> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final response = await http
          .get(Uri.https(_baseUrl, path, queryParameters), headers: headers)
          .timeout(const Duration(seconds: 10));

      // Handle different status codes - return success in the event of a 200, along with response body and a failure with message otherwise.
      switch (response.statusCode) {
        case 200:
          final body = json.decode(response.body);
          return ApiResponse.success(body);
        case 401:
          return const ApiResponse.failure('Unauthorized');
        case 404:
          return const ApiResponse.failure('Not found');
        default:
          return const ApiResponse.failure('Something went wrong');
      }
    } on SocketException {
      return const ApiResponse.failure('No internet connection');
    } on TimeoutException {
      return const ApiResponse.failure('Timeout');
    } on http.ClientException {
      return const ApiResponse.failure('Failed to connect to the server');
    }
  }

  // UPDATE
  @override
  Future<ApiResponse> patch({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> put({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) {
    // TODO: implement put
    throw UnimplementedError();
  }

  // DELETE
  @override
  Future<ApiResponse> delete({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
