class ApiResponse {
  /// Indicates whether the response is successful.
  final bool isSuccessful;

  /// Gets the data from the response.
  final dynamic data;

  /// Gets the message from the response.
  final String? message;

  /// Initialises the [ApiResponse] class that as successful and set the [data] object.
  const ApiResponse.success([this.data]) : isSuccessful = true, message = null;

  /// Initialises the [ApiResponse] class that as failed and sets the [message] object.
  const ApiResponse.failure(this.message) : isSuccessful = false, data = null;
}
