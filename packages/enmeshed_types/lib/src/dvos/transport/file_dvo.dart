import 'package:json_annotation/json_annotation.dart';

import '../common/common.dart';
import '../data_view_object.dart';
import 'identity_dvo.dart';

part 'file_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class FileDVO extends DataViewObject {
  final String filename;
  final int filesize;
  final String createdAt;
  final IdentityDVO createdBy;
  final String createdByDevice;
  final String expiresAt;
  final String mimetype;
  final bool isOwn;
  final String title;
  final String secretKey;

  const FileDVO({
    required super.id,
    required super.name,
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

  factory FileDVO.fromJson(Map json) => _$FileDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$FileDVOToJson(this);
}
