class DVOError {
  String code;
  String? message;

  DVOError({required this.code, this.message});

  factory DVOError.fromJson(Map json) => DVOError(code: json['code'], message: json['message']);
}
