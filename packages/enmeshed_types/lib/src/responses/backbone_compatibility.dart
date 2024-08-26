import 'package:json_annotation/json_annotation.dart';

part 'backbone_compatibility.g.dart';

@JsonSerializable(includeIfNull: false)
class CheckBackboneCompatibilityResponse {
  final bool isCompatible;
  final int backboneVersion;
  final int supportedMinBackboneVersion;
  final int supportedMaxBackboneVersion;

  CheckBackboneCompatibilityResponse({
    required this.isCompatible,
    required this.backboneVersion,
    required this.supportedMinBackboneVersion,
    required this.supportedMaxBackboneVersion,
  });

  factory CheckBackboneCompatibilityResponse.fromJson(Map<String, dynamic> json) => _$CheckBackboneCompatibilityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckBackboneCompatibilityResponseToJson(this);
}
