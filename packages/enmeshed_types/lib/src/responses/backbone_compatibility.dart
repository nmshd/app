import 'package:enmeshed_types/src/dvos/integer_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'backbone_compatibility.g.dart';

@JsonSerializable(includeIfNull: false)
class CheckBackboneCompatibilityResponse {
  final bool isCompatible;
  @IntegerConverter()
  final int backboneVersion;
  @IntegerConverter()
  final int supportedMinBackboneVersion;
  @IntegerConverter()
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
