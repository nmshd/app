import 'package:json_annotation/json_annotation.dart';

import '../../contents/response.dart';
import '../common/common.dart';
import '../data_view_object.dart';
import 'response_item_dvos.dart';

part 'response_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class ResponseDVO extends DataViewObject {
  final List<ResponseItemDVO> items;
  final ResponseResult result;

  const ResponseDVO({
    required super.id,
    required super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.items,
    required this.result,
  });

  factory ResponseDVO.fromJson(Map json) => _$ResponseDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$ResponseDVOToJson(this);
}
