


/// Represents a response from a data source.
class Response {
  const Response({required this.success, required this.message});

  Response.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool,
      message = json['message'] as String;

  // Whether the response indicates a successful operation.
  final bool success;

  // A message associated with the response, typically for user feedback.
  final String message;

  Map<String, dynamic> toJson() => {'success': success, 'message': message};
}
