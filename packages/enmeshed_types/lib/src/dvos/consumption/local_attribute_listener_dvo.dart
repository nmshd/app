import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../content/content.dart';
import '../data_view_object.dart';
import '../transport/transport.dart';

part 'local_attribute_listener_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class LocalAttributeListenerDVO extends DataViewObject {
  final AttributeQueryDVO query;
  final IdentityDVO peer;

  LocalAttributeListenerDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.query,
    required this.peer,
  });

  factory LocalAttributeListenerDVO.fromJson(Map json) => _$LocalAttributeListenerDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$LocalAttributeListenerDVOToJson(this);
}
