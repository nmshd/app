import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';

part 'request_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class RequestDVO extends DataViewObject {
  // TODO: Add fields

  RequestDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
  });

  factory RequestDVO.fromJson(Map<String, dynamic> json) => _$RequestDVOFromJson(json);
  Map<String, dynamic> toJson() => _$RequestDVOToJson(this);
}
