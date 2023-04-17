import 'package:equatable/equatable.dart';

class SyncInfoEntry extends Equatable {
  final String completedAt;

  const SyncInfoEntry({required this.completedAt});

  factory SyncInfoEntry.fromJson(Map<String, dynamic> json) => SyncInfoEntry(completedAt: json['completedAt']);

  static SyncInfoEntry? fromJsonNullable(Map<String, dynamic>? json) => json != null ? SyncInfoEntry.fromJson(json) : null;

  Map<String, dynamic> toJson() => {'completedAt': completedAt};

  @override
  String toString() => 'SyncInfoEntry(completedAt: $completedAt)';

  @override
  List<Object?> get props => [completedAt];
}
