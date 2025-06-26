import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

enum AnnouncementSeverity { low, medium, high }

@JsonSerializable(includeIfNull: false)
class AnnouncementDTO extends Equatable {
  final String id;
  final String createdAt;
  final String? expiresAt;
  final AnnouncementSeverity severity;
  final String title;
  final String body;
  final List<AnnouncementActionDTO> actions;

  const AnnouncementDTO({
    required this.id,
    required this.createdAt,
    this.expiresAt,
    required this.severity,
    required this.title,
    required this.body,
    required this.actions,
  });

  factory AnnouncementDTO.fromJson(Map json) => _$AnnouncementDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$AnnouncementDTOToJson(this);

  @override
  List<Object?> get props => [id, createdAt, expiresAt, severity, title, body];
}

@JsonSerializable(includeIfNull: false)
class AnnouncementActionDTO extends Equatable {
  final String displayName;
  final String link;

  const AnnouncementActionDTO({required this.displayName, required this.link});

  factory AnnouncementActionDTO.fromJson(Map json) => _$AnnouncementActionDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$AnnouncementActionDTOToJson(this);

  @override
  List<Object?> get props => [displayName, link];
}
