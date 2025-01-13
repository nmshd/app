// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_protection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordProtection _$PasswordProtectionFromJson(Map<String, dynamic> json) => PasswordProtection(
      password: json['password'] as String,
      passwordIsPin: json['passwordIsPin'] as bool?,
    );

Map<String, dynamic> _$PasswordProtectionToJson(PasswordProtection instance) => <String, dynamic>{
      'password': instance.password,
      if (instance.passwordIsPin case final value?) 'passwordIsPin': value,
    };
