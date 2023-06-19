import 'package:enmeshed_types/src/dvos/data_view_object.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';

part 'local_request_dvo.g.dart';

@JsonSerializable()
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

  factory LocalRequestDVO.fromJson(Map<String, dynamic> json) => _$LocalRequestDVOFromJson(json);
  Map<String, dynamic> toJson() => _$LocalRequestDVOToJson(this);
}
