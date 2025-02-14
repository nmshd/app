import 'package:equatable/equatable.dart';

class RequestValidationResultDTO extends Equatable {
  final bool isSuccess;
  final String? code;
  final String? message;
  final List<RequestValidationResultDTO> items;

  const RequestValidationResultDTO({required this.isSuccess, this.code, this.message, required this.items});

  factory RequestValidationResultDTO.fromJson(Map json) => RequestValidationResultDTO(
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

  @override
  List<Object?> get props => [isSuccess, code, message, items];
}
