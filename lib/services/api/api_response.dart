import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
sealed class ApiResponse with _$ApiResponse {
  const factory ApiResponse.success(
    Map<String, String> headers, [
    dynamic data,
  ]) = ApiResponseSuccess;

  const factory ApiResponse.failure(String message) = ApiResponseError;
}
