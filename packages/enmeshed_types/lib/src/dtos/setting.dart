import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

enum SettingScope { Identity, Device, Relationship }

@JsonSerializable(includeIfNull: false)
class SettingDTO extends Equatable {
  final String id;
  final String key;
  final SettingScope scope;
  final Map<String, dynamic> value;
  final String createdAt;
  final String? reference;
  final String? succeedsItem;
  final String? succeedsAt;

  const SettingDTO({
    required this.id,
    required this.key,
    required this.scope,
    required this.value,
    required this.createdAt,
    this.reference,
    this.succeedsItem,
    this.succeedsAt,
  });

  factory SettingDTO.fromJson(Map<String, dynamic> json) => _$SettingDTOFromJson(json);
  Map<String, dynamic> toJson() => _$SettingDTOToJson(this);

  @override
  List<Object?> get props => [];
}
