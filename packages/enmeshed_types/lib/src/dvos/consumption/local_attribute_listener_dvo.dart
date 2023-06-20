import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../content/content.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';

part 'local_attribute_listener_dvo.g.dart';

@JsonSerializable()
class LocalAttributeListenerDVO extends DataViewObject {
  final AttributeQueryDVO query;
  final IdentityDVO peer;

  LocalAttributeListenerDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.query,
    required this.peer,
  });

  factory LocalAttributeListenerDVO.fromJson(Map<String, dynamic> json) => _$LocalAttributeListenerDVOFromJson(json);
  Map<String, dynamic> toJson() => _$LocalAttributeListenerDVOToJson(this);
}
