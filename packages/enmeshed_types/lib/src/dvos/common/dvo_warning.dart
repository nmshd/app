import 'package:json_annotation/json_annotation.dart';

part 'dvo_warning.g.dart';

@JsonSerializable(includeIfNull: false)
class DVOWarning {
  String code;
  String? message;

  DVOWarning({required this.code, this.message});

  factory DVOWarning.fromJson(Map json) => _$DVOWarningFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$DVOWarningToJson(this);
}
