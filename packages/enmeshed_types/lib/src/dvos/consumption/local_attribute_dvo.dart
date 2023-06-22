import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';

part 'local_attribute_dvo.g.dart';

// TODO implement this library

@JsonSerializable(includeIfNull: false)
class LocalAttributeDVO extends DataViewObject {
  LocalAttributeDVO({required super.id, required super.type});

  factory LocalAttributeDVO.fromJson(Map<String, dynamic> json) => _$LocalAttributeDVOFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAttributeDVOToJson(this);
}
