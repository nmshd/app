import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../dtos/object_reference.dart';
import '../common/common.dart';
import '../data_view_object.dart';
import '../integer_converter.dart';
import 'identity_dvo.dart';

part 'file_dvo.g.dart';

@JsonSerializable(includeIfNull: false)
class FileDVO extends DataViewObject with EquatableMixin {
  final String filename;
  final List<String>? tags;
  @IntegerConverter()
  final int filesize;
  final String createdAt;
  final IdentityDVO createdBy;
  final String createdByDevice;
  final String expiresAt;
  final String mimetype;
  final bool isOwn;
  final String title;
  final ObjectReferenceDTO reference;
  final bool? wasViewed;

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
    this.tags,
    required this.filesize,
    required this.createdAt,
    required this.createdBy,
    required this.createdByDevice,
    required this.expiresAt,
    required this.mimetype,
    required this.isOwn,
    required this.title,
    required this.reference,
    this.wasViewed,
  });

  factory FileDVO.fromJson(Map json) => _$FileDVOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$FileDVOToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    image,
    type,
    date,
    error,
    warning,
    filename,
    tags,
    filesize,
    createdAt,
    createdBy,
    createdByDevice,
    expiresAt,
    mimetype,
    isOwn,
    title,
    reference,
    wasViewed,
  ];
}
