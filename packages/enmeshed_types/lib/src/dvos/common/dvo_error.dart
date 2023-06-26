import 'package:json_annotation/json_annotation.dart';

part 'dvo_error.g.dart';

@JsonSerializable(includeIfNull: false)
class DVOError {
  String code;
  String? message;

  DVOError({required this.code, this.message});

  factory DVOError.fromJson(Map json) => _$DVOErrorFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$DVOErrorToJson(this);
}
