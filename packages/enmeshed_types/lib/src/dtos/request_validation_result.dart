class RequestValidationResultDTO {
  final bool isSuccess;
  final String? code;
  final String? message;
  final List<RequestValidationResultDTO> items;

  RequestValidationResultDTO({
    required this.isSuccess,
    this.code,
    this.message,
    required this.items,
  });

  @override
  String toString() {
    return 'RequestValidationResult(isSuccess: $isSuccess, code: $code, message: $message, items: $items)';
  }

  factory RequestValidationResultDTO.fromJson(Map<String, dynamic> json) => RequestValidationResultDTO(
        isSuccess: json['isSuccess'],
        code: json['code'],
        message: json['message'],
        items: List<RequestValidationResultDTO>.from(json['items'].map((x) => RequestValidationResultDTO.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        if (code != null) 'code': code,
        if (message != null) 'message': message,
        'items': items.map((x) => x.toJson()).toList(),
      };
}
