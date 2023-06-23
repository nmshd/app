import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';

part 'local_request_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class LocalRequestDVO extends DataViewObject {
  // TODO: Add fields

  LocalRequestDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
  });

  factory LocalRequestDVO.fromJson(Map json) => _$LocalRequestDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$LocalRequestDVOToJson(this);
}
