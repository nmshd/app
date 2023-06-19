class DVOWarning {
  String code;
  String? message;

  DVOWarning({required this.code, this.message});

  factory DVOWarning.fromJson(Map json) => DVOWarning(code: json['code'], message: json['message']);
}
