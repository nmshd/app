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

  const AnnouncementDTO({required this.id, required this.createdAt, this.expiresAt, required this.severity, required this.title, required this.body});

  factory AnnouncementDTO.fromJson(Map json) => _$AnnouncementDTOFromJson(Map<String, dynamic>.from(json));
  Map<String, dynamic> toJson() => _$AnnouncementDTOToJson(this);

  @override
  List<Object?> get props => [id, createdAt, expiresAt, severity, title, body];
}
