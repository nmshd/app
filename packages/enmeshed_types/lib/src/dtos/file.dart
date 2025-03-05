import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable(includeIfNull: false)
class FileDTO extends Equatable {
  final String id;
  final String filename;
  final List<String>? tags;
  final int filesize;
  final String createdAt;
  final String createdBy;
  final String createdByDevice;
  final String expiresAt;
  final String mimetype;
  final bool isOwn;
  final String? title;
  final String? description;
  final String truncatedReference;

  const FileDTO({
    required this.id,
    required this.filename,
    this.tags,
    required this.filesize,
    required this.createdAt,
    required this.createdBy,
    required this.createdByDevice,
    required this.expiresAt,
    required this.mimetype,
    required this.isOwn,
    this.title,
    this.description,
    required this.truncatedReference,
  });

  factory FileDTO.fromJson(Map json) => _$FileDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$FileDTOToJson(this);

  @override
  List<Object?> get props => [
    id,
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
    description,
    truncatedReference,
  ];
}
