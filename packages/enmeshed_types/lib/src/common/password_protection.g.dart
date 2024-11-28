// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_protection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordProtection _$PasswordProtectionFromJson(Map<String, dynamic> json) => PasswordProtection(
      password: json['password'] as String,
      passwordIsPin: json['passwordIsPin'] as bool?,
    );

Map<String, dynamic> _$PasswordProtectionToJson(PasswordProtection instance) {
  final val = <String, dynamic>{
    'password': instance.password,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('passwordIsPin', instance.passwordIsPin);
  return val;
}
