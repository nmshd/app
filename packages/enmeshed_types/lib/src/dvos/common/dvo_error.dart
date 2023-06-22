import 'package:json_annotation/json_annotation.dart';

part 'dvo_error.g.dart';

@JsonSerializable(includeIfNull: false)
class DVOError {
  String code;
  String? message;

  DVOError({required this.code, this.message});

  factory DVOError.fromJson(Map<String, dynamic> json) => _$DVOErrorFromJson(json);
  Map<String, dynamic> toJson() => _$DVOErrorToJson(this);
}
