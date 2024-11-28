import 'package:json_annotation/json_annotation.dart';

part 'password_protection.g.dart';

@JsonSerializable(includeIfNull: false)
class PasswordProtection {
  final String password;
  final bool? passwordIsPin;

  const PasswordProtection({required this.password, this.passwordIsPin});

  factory PasswordProtection.fromJson(Map json) => _$PasswordProtectionFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$PasswordProtectionToJson(this);
}
