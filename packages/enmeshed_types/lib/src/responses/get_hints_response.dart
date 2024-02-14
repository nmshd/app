import 'package:json_annotation/json_annotation.dart';

import '../contents/contents.dart';

part 'get_hints_response.g.dart';

@JsonSerializable(includeIfNull: false)
class GetHintsResponse {
  final ValueHints valueHints;
  final RenderHints renderHints;

  GetHintsResponse({
    required this.valueHints,
    required this.renderHints,
  });

  factory GetHintsResponse.fromJson(Map<String, dynamic> json) => _$GetHintsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetHintsResponseToJson(this);
}
