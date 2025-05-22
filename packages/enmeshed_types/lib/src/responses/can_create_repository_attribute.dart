sealed class CanCreateRepositoryAttributeResponse {
  final bool isSuccess;

  CanCreateRepositoryAttributeResponse({required this.isSuccess});

  factory CanCreateRepositoryAttributeResponse.fromJson(Map json) {
    return switch (json['isSuccess']) {
      true => CanCreateRepositoryAttributeSuccessResponse(),
      false => CanCreateRepositoryAttributeFailureResponse(code: json['code'], message: json['message']),
      _ => throw ArgumentError('Invalid isSuccess value: ${json['isSuccess']}'),
    };
  }
}

class CanCreateRepositoryAttributeSuccessResponse extends CanCreateRepositoryAttributeResponse {
  CanCreateRepositoryAttributeSuccessResponse() : super(isSuccess: true);
}

class CanCreateRepositoryAttributeFailureResponse extends CanCreateRepositoryAttributeResponse {
  final String code;
  final String message;

  CanCreateRepositoryAttributeFailureResponse({required this.code, required this.message}) : super(isSuccess: false);
}
