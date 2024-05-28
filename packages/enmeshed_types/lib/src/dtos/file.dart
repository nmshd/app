import 'package:equatable/equatable.dart';

class FileDTO extends Equatable {
  final String id;
  final String filename;
  final int filesize;
  final String createdAt;
  final String createdBy;
  final String createdByDevice;
  final String expiresAt;
  final String mimetype;
  final bool isOwn;
  final String title;
  final String secretKey;
  final String? description;
  final String truncatedReference;

  const FileDTO({
    required this.id,
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
    this.description,
    required this.truncatedReference,
  });

  factory FileDTO.fromJson(Map json) => FileDTO(
        id: json['id'],
        filename: json['filename'],
        filesize: json['filesize'].toInt(),
        createdAt: json['createdAt'],
        createdBy: json['createdBy'],
        createdByDevice: json['createdByDevice'],
        expiresAt: json['expiresAt'],
        mimetype: json['mimetype'],
        isOwn: json['isOwn'],
        title: json['title'],
        secretKey: json['secretKey'],
        description: json['description'],
        truncatedReference: json['truncatedReference'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'filename': filename,
        'filesize': filesize,
        'createdAt': createdAt,
        'createdBy': createdBy,
        'createdByDevice': createdByDevice,
        'expiresAt': expiresAt,
        'mimetype': mimetype,
        'isOwn': isOwn,
        'title': title,
        'secretKey': secretKey,
        if (description != null) 'description': description,
        'truncatedReference': truncatedReference,
      };

  @override
  List<Object?> get props => [
        id,
        filename,
        filesize,
        createdAt,
        createdBy,
        createdByDevice,
        expiresAt,
        mimetype,
        isOwn,
        title,
        secretKey,
        description,
        truncatedReference,
      ];
}
