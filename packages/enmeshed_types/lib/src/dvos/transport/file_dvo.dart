import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';
import 'identity_dvo.dart';

part 'file_dvo.g.dart';

@JsonSerializable()
class FileDVO extends DataViewObject {
  String filename;
  int filesize;
  String createdAt;
  IdentityDVO createdBy;
  String createdByDevice;
  String expiresAt;
  String mimetype;
  bool isOwn;
  String title;
  String secretKey;

  FileDVO({
    required super.id,
    super.name,
    super.description,
    super.image,
    required super.type,
    super.date,
    super.error,
    super.warning,
    required this.filename,
    required this.filesize,
    required this.createdAt,
    required this.createdBy,
    required this.createdByDevice,
    required this.expiresAt,
    required this.mimetype,
    required this.isOwn,
    required this.title,
    required this.secretKey,
  });

  factory FileDVO.fromJson(Map<String, dynamic> json) => _$FileDVOFromJson(json);
  Map<String, dynamic> toJson() => _$FileDVOToJson(this);
}
