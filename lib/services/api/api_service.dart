import 'api.dart';

abstract interface class ApiService {
  // CREATE
  Future<ApiResponse> post({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });

  // READ
  Future<ApiResponse> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  // UPDATE
  Future<ApiResponse> patch({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });

  Future<ApiResponse> put({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });

  // DELETE
  Future<ApiResponse> delete({
    required String path,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });
}
