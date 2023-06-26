import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';
import 'request_item_dvos.dart';
import 'response_dvo.dart';

part 'request_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class RequestDVO extends DataViewObject {
  final String? expiresAt;
  final List<RequestItemDVO> items;
  final ResponseDVO? response;

  RequestDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    this.expiresAt,
    required this.items,
    this.response,
  });

  factory RequestDVO.fromJson(Map json) => _$RequestDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$RequestDVOToJson(this);
}
