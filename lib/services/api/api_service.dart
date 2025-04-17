import 'api.dart';

abstract interface class ApiService {
  // CREATE
  Future<ApiResponse> post({
    required Uri url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });

  // READ
  Future<ApiResponse> get({required Uri url, Map<String, String>? headers});

  // UPDATE
  Future<ApiResponse> patch({
    required Uri url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });

  Future<ApiResponse> put({
    required Uri url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });

  // DELETE
  Future<ApiResponse> delete({
    required Uri url,
    Map<String, String>? headers,
    required Map<String, dynamic> body,
  });
}
