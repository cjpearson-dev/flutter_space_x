class DataResponse<T> {
  /// Indicates whether the response is successful.
  final bool isSuccessful;

  /// Gets the content from the response.
  final T? content;

  /// Gets the message from the response.
  final String? message;

  /// The total amount of possible results when the response is a list.
  final int? maxCount;

  /// Initialises the [DataResponse] class that as successful and set the [content] object.
  DataResponse.success([this.content, this.maxCount])
    : isSuccessful = true,
      message = null;

  /// Initialises the [DataResponse] class that as failed and sets the [message] object.
  const DataResponse.failure(this.message)
    : isSuccessful = false,
      content = null,
      maxCount = null;
}
