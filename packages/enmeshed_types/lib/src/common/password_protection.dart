import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password_protection.g.dart';

@JsonSerializable(includeIfNull: false)
class PasswordProtection extends Equatable {
  final String password;
  final bool? passwordIsPin;

  const PasswordProtection({required this.password, this.passwordIsPin});

  factory PasswordProtection.fromJson(Map json) => _$PasswordProtectionFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() {
    final json = _$PasswordProtectionToJson(this);

    // properly handle the the runtime only accepts null or true which dart isn't able to display
    if (passwordIsPin == false) json.remove('passwordIsPin');

    return json;
  }

  @override
  List<Object?> get props => [password, passwordIsPin];
}
